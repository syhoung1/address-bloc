require_relative '../models/address_book.rb'

RSpec.describe AddressBook do
    let(:book) { AddressBook.new }

    def check_entry(entry, expected_name, expected_phone_number, expected_email)
        expect(entry.name).to eq expected_name
        expect(entry.phone_number).to eq expected_phone_number
        expect(entry.email).to eq expected_email
    end

    describe "attributes" do
        it "responds to entries" do
            expect(book).to respond_to(:entries)
            book.import_from_csv("entries.csv")

            entry_one = book.entries[0]

            check_entry(entry_one, "Jacob", "555-555-5552", "Jacob@at.com")
        end
        
        it "imports the second entry" do
            book.import_from_csv("entries.csv")
            entry_two = book.entries[1]

            check_entry(entry_two, "Jill", "555-555-5555", "Jill@at.com")
        end
        
        it "imports the third entry" do
            book.import_from_csv("entries.csv")
            entry_three = book.entries[2]

            check_entry(entry_three, "Jingleheimer", "555-555-5553", "Jingleheimer@at.com")
        end
        
        it "imports the fourth entry" do
            book.import_from_csv("entries.csv")
            entry_four = book.entries[3]

            check_entry(entry_four, "John", "555-555-5551", "John@at.com")
        end
        
        it "imports the fifth entry" do
            book.import_from_csv("entries.csv")
            entry_five = book.entries[4]

            check_entry(entry_five, "Schmidt", "555-555-5554", "Schmidt@at.com")
        end

        it "initializes entries as an array" do
            expect(book.entries).to be_an(Array)
        end

        it "initializes entries as empty" do
            expect(book.entries.size).to eq(0)
        end
    end

    describe "#add_entry" do

        it "adds only one entry to the address book" do
            book.add_entry('daniel', '123.456.7890', 'daniel@daniel.com')

            expect(book.entries.size).to eq(1)
        end

        it "adds the correct information to entries" do
            book.add_entry('daniel', '123.456.7890', 'daniel@daniel.com')
            new_entry = book.entries[0]
            
            expect(new_entry.name).to eq('daniel')
            expect(new_entry.phone_number).to eq('123.456.7890')
            expect(new_entry.email).to eq('daniel@daniel.com')
        end
    end

    describe "#import_from_csv" do
        it "imports the correct number of entries" do
            book.import_from_csv("entries.csv")
            book_size = book.entries.size

            expect(book_size).to eq 5
        end
    end

    describe "#binary_search" do
        it "searches AddressBook for nonexistent entry" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Dan")
            expect(entry).to be_nil
        end

        it "searches AddressBook for Jacob" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Jacob")
            expect(entry).to be_a Entry
            check_entry(entry, "Jacob", "555-555-5552", "Jacob@at.com")
        end

        it "searches AddressBook for Jill" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Jill")
            expect(entry).to be_a Entry
            check_entry(entry, "Jill", "555-555-5555", "Jill@at.com")
        end

        it "searches AddressBook for Jingleheimer" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Jingleheimer")
            expect(entry).to be_a Entry
            check_entry(entry, "Jingleheimer", "555-555-5553", "Jingleheimer@at.com")
        end

        it "searches AddressBook for John" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("John")
            expect(entry).to be_a Entry
            check_entry(entry, "John", "555-555-5551", "John@at.com")
        end

        it "searches AddressBook for Schmidt" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Schmidt")
            expect(entry).to be_a Entry
            check_entry(entry, "Schmidt", "555-555-5554", "Schmidt@at.com")
        end
        
        it "searches AddressBook for Jon" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Jon")
            expect(entry).to be_nil
        end
    end
end
