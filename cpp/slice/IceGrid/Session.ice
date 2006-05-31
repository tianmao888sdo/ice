// **********************************************************************
//
// Copyright (c) 2003-2006 ZeroC, Inc. All rights reserved.
//
// This copy of Ice is licensed to you under the terms described in the
// ICE_LICENSE file included in this distribution.
//
// **********************************************************************

#ifndef ICE_GRID_SESSION_ICE
#define ICE_GRID_SESSION_ICE

#include <Glacier2/Session.ice>
#include <IceGrid/Exception.ice>

module IceGrid
{

interface Session extends Glacier2::Session
{
    /**
     *
     * Keep the session alive. Clients should call this method
     * regularly to prevent the server from reaping the session.
     *
     * @see getTimeout
     *
     **/
    void keepAlive();

    /**
     *
     * Get the session timeout. If a client doesn't call keepAlive in
     * the time interval defined by this timeout, IceGrid might reap
     * the session.
     *
     * @see keepAlive
     *
     * @return The timeout in milliseconds.
     *
     **/
    nonmutating int getTimeout();

    /**
     *
     * Allocate an object. Depending on the allocation timeout, this
     * method might hang until the object is available or until the
     * timeout is reached.
     * 
     * @param id The identity of the object to allocate.
     *
     * @return The proxy of the allocated object.
     *
     * @throws ObjectNotRegisteredException Raised if the object with
     * the given identity is not registered with the registry.
     *
     * @throws AllocationException Raised if the object can't be
     * allocated.
     *
     **/
    ["ami", "amd"] Object* allocateObjectById(Ice::Identity id)
	throws ObjectNotRegisteredException, AllocationException;
    
    /**
     *
     * Allocate an object with the given type. Depending on the
     * allocation timeout, this method might hang until an object
     * becomes available or until the timeout is reached.
     *
     * @param type The type of the object.
     *
     * @return The proxy of the allocated object.
     *
     * @throws Raised if no objects with the given type can be
     * allocated.
     *
     **/
    ["ami", "amd"] Object* allocateObjectByType(string type)
	throws AllocationException;
    
    /**
     *
     * Release an object.
     *
     * @param id The identity of the object to release.
     *
     * @throws ObjectNotRegisteredException Raised if the object with
     * the given identity is not registered with the regitry.
     *
     * @throws AllocationException Raised if the given object can't be
     * released. This might happen if the object isn't allocatable or
     * allocated by the session.
     *
     **/
    void releaseObject(Ice::Identity id)
	throws ObjectNotRegisteredException, AllocationException;
    
    /**
     *
     * Set the allocation timeout. If no objects are available for an
     * allocation request, the request will hang for the duration of 
     * this timeout.
     *
     * @param timeout The timeout in milliseconds.
     *
     **/
    void setAllocationTimeout(int timeout);
};

};

#endif
