"use strict"

chai = require "chai"
expect = chai.expect
sinon = require "sinon"
sinonChai = require "sinon-chai"
chai.use sinonChai

ObservableValue = require "index"
SimplePublisher = require "amo.modules.simple_publisher"

describe "ObservableValue", ->
  it "should be subclass of SimplePublisher", ->
    expect(ObservableValue.__super__).to.be.equal SimplePublisher.prototype

  describe "its instance", ->
    obj = null
    beforeEach ->
      obj = ObservableValue.create()

    it "should have addProperty", ->
      expect(obj).to.have.property "addProperty"

    it "should have addProperties", ->
      expect(obj).to.have.property "addProperties"

    describe "addProperty", ->
      it "should add property", ->
        expect(obj.hoge).to.be.undefined
        obj.addProperty "hoge", 100
        expect(obj.hoge).to.be.equal 100

      it "should return itself", ->
        expect(obj.addProperty "hoge", 100).to.be.equal obj

      it "a property it adds should publish when its value is changed", (done) ->
        old = 10
        newVal = 100
        listener = (o, n) ->
          expect(o).to.be.equal old
          expect(n).to.be.equal newVal
          done()
        obj.register "hoge", listener
        obj.addProperty "hoge", old
        obj.hoge = newVal

    describe "addProperties", ->
      it "should call addProperty", ->
        spy = sinon.spy obj, "addProperty"
        obj.addProperties
          hoge: "fuga"
          fizz: "buzz"

        expect(spy).to.have.been.calledWith "hoge", "fuga"
        expect(spy).to.have.been.calledWith "fizz", "buzz"
        expect(spy).to.have.callCount 2

  describe "initialize instance with props", ->
    it "should call addProperties", ->
      spy = sinon.spy ObservableValue.prototype, "addProperties"
      props =
        hoge: "fuga"
        fizz: "buzz"
      ObservableValue.create props
      expect(spy).to.have.been.calledWith props
      expect(spy).to.have.callCount 1
