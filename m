Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59553274B29
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Sep 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435641; cv=none; b=lCDUinR+GXoh67J/SZh62y+405MG5VHJFRpnsbdVyByFtWwR901W8zhUd8niQrCtdFUd6Ag6/XZiyINS8zQM3qN04nFSUIZgxqg+atX5eXKWLcygyuSY8CEOmTZcdIXBaRDcxT+ixEKgriGlH+dhzAlhxK4JMcVUILGIfxLeb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435641; c=relaxed/simple;
	bh=C1HrpZzDh0y+3xiKzGEzgVmOvQ4YMGunUJPAUm5Xa7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rCb4K+HAeyNFCuwRlgyX2tmLRBk5mMXH9LtgRolX7ifz1el9Bp1hm0wxNjnGzv1qrc+nUa1TpW0IyQ5W6gwRdy8EEp+khpkII1/TuNVBii5q2ts+5X1zXXyI6i9E0QICDirQNsLLwZ55RZzFpDHriK7R74toGp4RB5/nDVqhWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lkz03nlX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lkz03nlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757435638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ePoGCaIdGXbWphESLZAeItbSBBgKt5/MPomic37fOM=;
	b=Lkz03nlXZuSgxibw00f7kxV9AWvmyJ0X/ldV9C7xOKp7E7PtRwEma0nufYx/JlG8CGgzat
	XkqpInBPbrUvUghXcN6z8xWVzoKHEghVp6YSljRn2d/ODukrEhmXN49PmDPaTN2PtFhrQw
	Ri8ODxpaVqbvTiWFW1ndnLm9xG71qZ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-qnb2A01uNXm1tuD-mUuTWw-1; Tue,
 09 Sep 2025 12:33:54 -0400
X-MC-Unique: qnb2A01uNXm1tuD-mUuTWw-1
X-Mimecast-MFC-AGG-ID: qnb2A01uNXm1tuD-mUuTWw_1757435631
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 081FB180065C;
	Tue,  9 Sep 2025 16:32:57 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.225.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EEFB3000198;
	Tue,  9 Sep 2025 16:32:53 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
  libc-alpha@sourceware.org,  John Ogness <john.ogness@linutronix.de>,
  linux-rt-devel@lists.linux.dev,  Thomas Gleixner <tglx@linutronix.de>,
  Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
In-Reply-To: <20250909153758.JD5t64rY@linutronix.de> (Sebastian Andrzej
	Siewior's message of "Tue, 9 Sep 2025 17:37:58 +0200")
References: <20250908163329.Qq79ujq_@linutronix.de>
	<4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
	<20250909073226.0qoHYZMo@linutronix.de>
	<lhubjnjbyt9.fsf@oldenburg.str.redhat.com>
	<20250909153758.JD5t64rY@linutronix.de>
Date: Tue, 09 Sep 2025 18:32:51 +0200
Message-ID: <lhubjnja8ng.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A2avm64i_k-j6jvEqaGa3o8oZSyFl6lCxv_-Y47NVeE_1757435631
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

* Sebastian Andrzej Siewior:

>> Are there seccomp filters for PI futexes?  I wouldn't be surprised if
>> people added them after some of the high-profile futex vulnerabilities.
>> I think we should not support such seccomp filters, but we need to know
>> what we are up against.
>
> I don't know. But don't you allow a syscall such a sys_futex and don't
> filter additional arguments? Unless one would filter the op argument, it
> shouldn't be an issue.

There's this historic example:

  Remove priority inheritance support for Futex in all Chrome policies,
  including NaCl NonSFI
  <https://issues.chromium.org/issues/40381864>

Some applications are exactly doing that, though, particularly for
FUTEX_CMP_REQUEUE_PI.

Given how widely the Chromium sandbox code is used, I wonder if this is
still an issue.

>> > There shouldn't be any error. There might be the case where the lock
>> > owner is gone (ESRCH I believe) or the theoretical ENOMEM. ESRCH isn't
>> > handled now but it can't be recognized either. It would require to kill
>> > the thread owning the lock.
>> > So either abort the operation if the futex-op returns an error because
>> > "this shouldn't happen" or I don't know.
>> 
>> ENOMEM needs to be reported to the caller because the application may
>> want to react to it.
>
> Well. Right now it only checks ESRCH and EDEADLK. Everything else is
> considered success.
> So do want to update this + man-page?

The man page already mentions ENOMEM, it's just glibc that is buggy.

> But what should be done this pthread_cond_.*() functions? I guess we
> can't forward that possible -ENOMEM to the caller?

Is this about the wait operation?  POSIX allows spurious wakeups, so we
could technically return without an error.

> Also if we are in good mood, there pthread_mutex_lock() has this comment
> |                 /* ESRCH can happen only for non-robust PI mutexes where
> |                    the owner of the lock died.  */
>
> This is simply not true as far as the kernel goes. If the futex uaddr
> contains a pid of a non-existing task then LOCK_PI will return ESRCH. A
> simple testcase would be
>
> | #include <stdio.h>
> | #include <pthread.h>
> |
> | static pthread_mutex_t l;
> |
> | static void *thread_code(void *arg)
> | {
> |         pthread_mutex_lock(&l);
> |         return NULL;
> | }
> |
> | int main(void)
> | {
> |         pthread_mutexattr_t attr;
> |         pthread_t thread;
> |         int ret;
> |
> |         ret = pthread_mutexattr_init(&attr);
> |         ret |= pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
> |         ret |= pthread_mutex_init(&l, &attr);
> |         ret |= pthread_create(&thread, NULL, thread_code, NULL);
> |         if (ret) {
> |                 printf("->[%d] %d\n", __LINE__, ret);
> |                 return 1;
> |         }
> |         pthread_join(thread, NULL);
> |         ret = pthread_mutex_lock(&l);
> |         printf("-> %d %m\n", ret);
> |
> |         return 0;
> | }
>
> and strace says:
> | futex(0x55afb0ceb080, FUTEX_LOCK_PI_PRIVATE, NULL) = -1 ESRCH (No such process)
> | futex(0x7ffe73216f24, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, NULL, FUTEX_BITSET_MATCH_ANY
>
> the second futex() is the __futex_abstimed_wait64() that follows.

Does POSIX define what happens if a non-robust mutex is accessed again
if a thread terminates without unlocking it first?  If yes, then this is
indeed a problem.

Thanks,
Florian

