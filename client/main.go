package main

import (
	pb "Task_3/proto"
	"context"
	"google.golang.org/grpc"
	"log"
	"time"
)

const (
	address = "localhost:443"
)

func createUserClient(c pb.MemoryBookServiceClient, ctx context.Context) {
	const (
		name         = "Paritosh Joshi"
		emailAddress = "paritoshj1619@gmail.com"
	)
	res, err := c.CreateUser(ctx, &pb.User{Name: name, EmailAddress: emailAddress})
	if err != nil {
		log.Fatalf("Could not create user: %v\n", err)
	}
	log.Printf(`\nUser Details:\n
	NAME: %s
	EMAIL_ADDRESS: %s
	ID: %d
	SECRET_CODE: %s`, res.GetName(), res.GetEmailAddress(), res.GetId(), res.GetSecretCode())
}

func loginUserClient(c pb.MemoryBookServiceClient, ctx context.Context) {
	const (
		secretCode = "Zbsijal"
	)
	res, err := c.Login(ctx, &pb.User{SecretCode: secretCode})
	if err != nil {
		log.Fatalf("Could not login user: %v\n", err)
	}
	log.Printf(`\nUser logged in:\n
	NAME: %s
	EMAIL_ADDRESS: %s
	ID: %d
	SECRET_CODE: %s`, res.GetName(), res.GetEmailAddress(), res.GetId(), res.GetSecretCode())
}

func storePhotoClient(c pb.MemoryBookServiceClient, ctx context.Context) {
	const (
		description = "This is photo description."
		location    = "This is address of this photo."
		secretCode  = "Zbsijal"
	)
	byteCode := []byte{98, 78, 67, 88, 91, 94, 99}
	res, err := c.StorePhoto(ctx, &pb.Photo{ByteCode: byteCode, Description: description, Location: location, SecretCode: secretCode})
	if err != nil {
		log.Fatalf("Could not store photo: %v\n", err)
	}
	log.Printf(`\nPhoto Details:\n
	ID: %d
	BYTE_CODE: %v
	DESCRIPTION: %s
	ADDRESS: %s
	DATE_OF_CREATION: %s
	SECRET_CODE: %s`, res.GetId(), res.GetByteCode(), res.GetDescription(), res.GetLocation(), res.GetDateOfCreation(), res.GetSecretCode())
}

func getAllPhotosClient(c pb.MemoryBookServiceClient, ctx context.Context) {
	const (
		secretCode = "Zbsijal"
	)
	res, err := c.GetAllPhotos(ctx, &pb.Photo{SecretCode: secretCode})
	if err != nil {
		log.Fatalf("Could not get all photos: %v\n", err)
	}
	log.Printf(`\nAll photos:\n
	%v`, res.GetPhotos())
}

func updatePhotosClient(c pb.MemoryBookServiceClient, ctx context.Context) {
	const (
		id          = 1
		location    = "Updated Address."
		description = "Updated Description."
	)
	res, err := c.UpdatePhoto(ctx, &pb.Photo{Id: id, Location: location, Description: description})
	if err != nil {
		log.Fatalf("Could not update photo: %v\n", err)
	}
	log.Printf(`\nPhoto Updated:\n
	ID: %d
	BYTE_CODE: %v
	DESCRIPTION: %s
	ADDRESS: %s
	DATE_OF_CREATION: %s
	SECRET_CODE: %s`, res.GetId(), res.GetByteCode(), res.GetDescription(), res.GetLocation(), res.GetDateOfCreation(), res.GetSecretCode())
}

func deletePhotoClient(c pb.MemoryBookServiceClient, ctx context.Context) {
	const (
		id = 1
	)
	_, err := c.DeletePhoto(ctx, &pb.Photo{Id: id})
	if err != nil {
		log.Fatalf("Could not delete photo: %v\n", err)
	}
	log.Printf(`\nPhoto Deleted.\n`)
}

func main() {
	conn, err := grpc.Dial(address, grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		log.Fatalf("Did not connect: %v\n", err)
	}
	defer conn.Close()
	cUser := pb.NewMemoryBookServiceClient(conn)
	cPhoto := pb.NewMemoryBookServiceClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	createUserClient(cUser, ctx)
	loginUserClient(cUser, ctx)
	storePhotoClient(cPhoto, ctx)
	getAllPhotosClient(cPhoto, ctx)
	updatePhotosClient(cPhoto, ctx)
	deletePhotoClient(cPhoto, ctx)
}
