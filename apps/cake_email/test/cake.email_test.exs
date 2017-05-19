defmodule Cake.EmailTest do
    use ExUnit.Case
    alias Cake.Email
    doctest Email

    defmodule TestTemplate do
        defstruct [
            formatter: &TestTemplate.format/1,
            name: nil,
            message: nil
        ]

        def format(%{ name: name, message: message }) do
            %Email{
                subject: "A test message",
                body: %Email.Body{
                    text: "Hi #{name}, #{message}."
                }
            }
        end
    end

    test "custom template" do
        assert %Email{
            subject: "A test message",
            body: %Email.Body{ text: "Hi Foo, Bar." }
        } == Email.compose(%TestTemplate{ name: "Foo", message: "Bar" })
    end

    test "overriding fields" do
        assert %Email{
            subject: "test",
            body: %Email.Body{ text: "Hi Foo, Bar." }
        } == Email.compose(%TestTemplate{ name: "Foo", message: "Bar" }, subject: "test")
    end
end
