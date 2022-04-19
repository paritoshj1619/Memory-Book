package main

import (
	pb "Task_3/proto"
	"context"
	"errors"
	"google.golang.org/grpc"
	"log"
	"math/rand"
	"net"
	"sync"
)

const (
	port = ":443" //Always use

)

type Server struct {
	pb.UnimplementedMemoryBookServiceServer
}

var users = map[string]*pb.User{}
var photos = map[int32]*pb.Photo{}
var mu sync.Mutex

var letterRunes = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

func randStr() string {
	b := make([]rune, 7)
	for i := range b {
		b[i] = letterRunes[rand.Intn(len(letterRunes))]
	}
	return string(b)
}

func (s *Server) CreateUser(ctx context.Context, req *pb.User) (*pb.User, error) {
	mu.Lock()
	var userId int32 = int32(len(users) + 1)
	secretCode := randStr()
	createdUser := &pb.User{Name: req.GetName(), EmailAddress: req.GetEmailAddress(), Id: userId, SecretCode: secretCode}
	users[secretCode] = createdUser
	mu.Unlock()
	return createdUser, nil
}

func (s *Server) Login(ctx context.Context, req *pb.User) (*pb.User, error) {
	secretCode := req.GetSecretCode()
	if users[secretCode] == nil {
		return nil, errors.New("cannot find user")
	} else {
		return users[secretCode], nil
	}
}

func (s *Server) StorePhoto(ctx context.Context, req *pb.Photo) (*pb.Photo, error) {
	if users[req.GetSecretCode()] == nil {
		return nil, errors.New("user not found")
	}
	mu.Lock()
	photoId := int32(len(photos) + 1)
	photo := &pb.Photo{Id: photoId, ByteCode: req.GetByteCode(), Description: req.GetDescription(), DateOfCreation: req.GetDateOfCreation(), Location: req.GetLocation(), SecretCode: req.GetSecretCode()}
	photos[photoId] = photo
	mu.Unlock()
	return photo, nil
}

func (s *Server) GetAllPhotos(ctx context.Context, req *pb.Photo) (*pb.Photos, error) {
	secretCode := req.GetSecretCode()
	if users[secretCode] == nil {
		return nil, errors.New("user not found")
	}
	photoList := &pb.Photos{}
	for _, v := range photos {
		if v.SecretCode == secretCode {
			photoList.Photos = append(photoList.Photos, v)
			break
		}
	}
	if len(photoList.Photos) == 0 {
		return nil, errors.New("no photos found")
	}
	return photoList, nil
}

func (s *Server) UpdatePhoto(ctx context.Context, req *pb.Photo) (*pb.Photo, error) {
	if users[req.SecretCode] == nil {
		return nil, errors.New("user not found")
	}
	if photos[req.Id] == nil {
		return nil, errors.New("photo not found")
	}
	photoId := req.GetId()
	description := req.GetDescription()
	location := req.GetLocation()
	photo := photos[photoId]
	photo.Description = description
	photo.Location = location
	mu.Lock()
	photos[photoId] = photo
	mu.Unlock()
	return photo, nil
}

func (s *Server) DeletePhoto(ctx context.Context, req *pb.Photo) (*pb.Void, error) {
	if photos[req.Id] == nil {
		return nil, errors.New("photo not found")
	}
	mu.Lock()
	photoId := req.GetId()
	delete(photos, photoId)
	mu.Unlock()
	return &pb.Void{}, nil
}

func main() {

	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	srv := grpc.NewServer()
	pb.RegisterMemoryBookServiceServer(srv, &Server{})
	log.Printf("Server listening at %v", lis.Addr())
	if err := srv.Serve(lis); err != nil {
		log.Fatalf("Failed to server: %v\n", err)
	}
}
