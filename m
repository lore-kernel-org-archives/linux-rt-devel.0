Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5629260568
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Sep 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432284; cv=none; b=aBlKvn8rzl2l0fkK/kXY3rFGdrYT6yTiKewCnKZW5SdIolqpqqTqIhqrAwy718KQus1v2uaqMuRX2GvyUlPvjIQcgdjdpHczcA7/q+2gq35lrsr7tWHsa1Vlrw1mMUCkuJBIoIoudLodX9a74/1WQFlWEn9iWu5mc3GXWIopbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432284; c=relaxed/simple;
	bh=uVa7rv8WnVX9jK+W7cmW6hgGCt5Oa49hY9H3l547yCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooyDnwgfDAyHr+mGMIlvsqdJGZetApqq8iVvnCavV4Rv2zy98MZgfu1gIg1cElnJEZG4FN27ad+ScMPVO5GyXU1MJJXXZKv8OTCkbSotAFq57I+B0YwgkVODOIOQK6TObYwA9B8c7w1rbJuStRYOKqnCx7WP4OZ4PUCeUj5sJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nEZVNFX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+hozzL66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nEZVNFX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+hozzL66"
Date: Tue, 9 Sep 2025 17:37:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757432280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1KSbfcHjRDSBGvmE/uhCpEBQTgyNwkbVyRlgBt/9aU=;
	b=3nEZVNFX4NFCfe2K4iRgYG7pvupCUlgfZmLyxklfESllkAj9Vt+9zBZRl+edrjga7tsg2Q
	8iRbmYRY/YD7iFx1xs4Kro+ZU3D19NLql2I0Xp5VpoAjF3ENxZUPi7SMT8NZawCPMYUmIw
	J3rVofR2UdmeDfrSRq+QU6o2/WRKvYORDBPMG0zXOgtFDZb/nOtSiC1pOSFlRWf+d2PPVN
	qccSHbc1wIDiTu9pojIRZJS/cbaaYZxDOrIHsD/FEphW7UseiXQ1fypOc1iaKD7f2GB+Xh
	hwn0D60AgwIG+L+HhlKTBTwVr5uxpfsipbC6Rqs7Gubx9llb3GNvwK49TqURmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757432280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1KSbfcHjRDSBGvmE/uhCpEBQTgyNwkbVyRlgBt/9aU=;
	b=+hozzL66Z4p3A6bem3ukgrFrGmz3J4eaZ8Y6FKOhyjxRRb4tcMt4OaE9mU1nIb/FyE8HXG
	WTX6R8cl+lgy8iCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	libc-alpha@sourceware.org, John Ogness <john.ogness@linutronix.de>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
Message-ID: <20250909153758.JD5t64rY@linutronix.de>
References: <20250908163329.Qq79ujq_@linutronix.de>
 <4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
 <20250909073226.0qoHYZMo@linutronix.de>
 <lhubjnjbyt9.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <lhubjnjbyt9.fsf@oldenburg.str.redhat.com>

On 2025-09-09 14:22:26 [+0200], Florian Weimer wrote:
> * Sebastian Andrzej Siewior:
>=20
> > On 2025-09-08 14:46:12 [-0300], Adhemerval Zanella Netto wrote:
> >> > This change expects that PI-FUTEX is supported by the kernel. This is
> >> > the case since a long time but it is possible to disable the FUTEX
> >> > subsystem or the FUTEX_PI part of it while building the kernel.
> >> > Is it okay to assume that PI-FUTEX is available or should there be a
> >> > check somewhere during startup and in case of -ENOSYS a fallback to
> >> > current implementation?
> >>=20
> >> We removed the __ASSUME_FUTEX_LOCK_PI (f5c77f78ec03363d5e550c4996deb75=
ee3f2e32a)
> >> in favor or always check for PI support at runtime during pthread_mute=
x_init
> >> (prio_inherit_missing).
> >>=20
> >> Since the kernel still might return ENOSYS for FUTEX_PI I think we sho=
uld
> >> keep probing its support as runtime.
> >
> > Okay. Since that one is static, I guess I would have to make my own
> > check in pthread_cond.
> >
> > But=E2=80=A6 Now that I look at it again. The kernel has this FUTEX_PI =
option
> > which depends on RT_MUTEXES. But RT_MUTEXES has no off switch so it must
> > always be selected once FUTEX itself is enabled. The I2C subsystem
> > selects RT_MUTEXES and I don't think there is a config without PI-FUTEX
> > considering this.
> > We _used_ to have runtime detection for PI-FUTEX support because not all
> > architectures provided a cmpxchg function for futex. This is gone and
> > all architectures as of v5.17 provide it. That would be commit
> >    3297481d688a5 ("futex: Remove futex_cmpxchg detection")
> >    https://git.kernel.org/torvalds/c/3297481d688a5
> >
> > for reference. So I *think* this config option can be removed on kernel
> > side and it appears to me as of v5.17 there should be no need for a
> > runtime check regarding PI-futex.
>=20
> Are there seccomp filters for PI futexes?  I wouldn't be surprised if
> people added them after some of the high-profile futex vulnerabilities.
> I think we should not support such seccomp filters, but we need to know
> what we are up against.

I don't know. But don't you allow a syscall such a sys_futex and don't
filter additional arguments? Unless one would filter the op argument, it
shouldn't be an issue. There was this switch from sys_futex to
sys_futex_time64 on 32bit architectures but this is more a permanent
switch=E2=80=A6
And libc doesn't use sys_futex_wake, sys_futex_wait which would make a
difference in this case. So unless op is checked, it should be fine.

> > There shouldn't be any error. There might be the case where the lock
> > owner is gone (ESRCH I believe) or the theoretical ENOMEM. ESRCH isn't
> > handled now but it can't be recognized either. It would require to kill
> > the thread owning the lock.
> > So either abort the operation if the futex-op returns an error because
> > "this shouldn't happen" or I don't know.
>=20
> ENOMEM needs to be reported to the caller because the application may
> want to react to it.

Well. Right now it only checks ESRCH and EDEADLK. Everything else is
considered success.
So do want to update this + man-page?
But what should be done this pthread_cond_.*() functions? I guess we
can't forward that possible -ENOMEM to the caller?

Also if we are in good mood, there pthread_mutex_lock() has this comment
|                 /* ESRCH can happen only for non-robust PI mutexes where
|                    the owner of the lock died.  */

This is simply not true as far as the kernel goes. If the futex uaddr
contains a pid of a non-existing task then LOCK_PI will return ESRCH. A
simple testcase would be

| #include <stdio.h>
| #include <pthread.h>
|
| static pthread_mutex_t l;
|
| static void *thread_code(void *arg)
| {
|         pthread_mutex_lock(&l);
|         return NULL;
| }
|
| int main(void)
| {
|         pthread_mutexattr_t attr;
|         pthread_t thread;
|         int ret;
|
|         ret =3D pthread_mutexattr_init(&attr);
|         ret |=3D pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERI=
T);
|         ret |=3D pthread_mutex_init(&l, &attr);
|         ret |=3D pthread_create(&thread, NULL, thread_code, NULL);
|         if (ret) {
|                 printf("->[%d] %d\n", __LINE__, ret);
|                 return 1;
|         }
|         pthread_join(thread, NULL);
|         ret =3D pthread_mutex_lock(&l);
|         printf("-> %d %m\n", ret);
|
|         return 0;
| }

and strace says:
| futex(0x55afb0ceb080, FUTEX_LOCK_PI_PRIVATE, NULL) =3D -1 ESRCH (No such =
process)
| futex(0x7ffe73216f24, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, =
NULL, FUTEX_BITSET_MATCH_ANY

the second futex() is the __futex_abstimed_wait64() that follows.

> Long term, we should probably have different interfaces for full locking
> (with expected failures during locking) and simple mutexes (where
> locking can only fail due to memory corruption).
>=20
> Unlocking must never fail with ENOMEM or similar error codes, it must
> always suceed (except if there is memory corruption).

UNLOCK_PI. There is no ENOMEM, unlock always succeeds.
Except for pilot errors:
- EFAULT (can't read, uaddr not properly aligned)
- EPERM (we are not owner).
- EAGAIN if userland fiddled with with the value while kernel tried to
  unlock. This _shouldn't_ happen because if the 0->tid transition fails
  the user should go to kernel. But if it fiddles, EAGAIN will be a
  possible outcome.

> Thanks,
> Florian

Sebastian
