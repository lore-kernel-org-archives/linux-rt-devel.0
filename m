Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848173;
	b=UJL969CBAgVwHweAJhhIaAfQ5tBNyzCvrI5s6NGZEtnd1kS9Yca8CKHaQpJXNybsTRx9
	 2HZG0LMt4XKucZeyiwM/Xj0SWiF2cNw2qcopRrZFCLWdhLxFlcykV9sl9SWUZ0aY4xexA
	 CcIji65nJ5PglPhJ2jfhIVYpO//Tg6cySlIlqLntAQ4ORdkdaoevs9cJx/dO02Rdai1eR
	 N+lC0Y+Guthr3UeZ2Z/czIh6rCQzBAulx6IGcdF4MDYMZ/UFY1rJNKs2cjBQlFhiFEYOZ
	 Y+EAJTMbPntulzyA8C9our/ApdQkG2rUpXKvWOrOkMVEeD7zJWPjVB0ro5aAEcpUqEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848173;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=RDsIwsWu1KfQS3Aqtw59xAzqiLwWxmSzDSkW35hSn/U=;
	b=bLgFiAl0SxyFyIsiIkQUKj9tmolbK0tEDBIjtUbo7onJKUOZSpfqvRn49MU4Yc14c1fa
	 jO8Wmr0ETzBw346ghabF7ykiK879q29AHuoeiTuSRXUsIM4pL21bqPQvksLGIXCPvGpdg
	 z0HFw6mVYmsJrrXXnRBBiZNl9mYQMQcD0vbiKPMymgg7MIlzKPn1w79sFr/pFFVtMRv5X
	 wKQ9r6PCzQFK2DhcETfu9phRmk3kdUl7JQgUSGIG/C7EzF0+C6ojnQ2DeN6SYVVklQ1Ez
	 7A5lu3Qn1hugVTE7mh1u1IX8WWupNvXx7+debegUBEVBKjFrStfG+N31nss81FQycXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=X671Sey6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=e1DFnPa7;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74A606A336
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 16:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA74A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=X671Sey6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=e1DFnPa7
Date: Mon, 16 Nov 2026 17:56:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794848170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDsIwsWu1KfQS3Aqtw59xAzqiLwWxmSzDSkW35hSn/U=;
	b=X671Sey6zOnA4g/Gc3LkOkWUY5RmzW1FV6Vp94tpgKxE81m3B7vjOcb6xeWO2gOzVuiM59
	IRFp5B1mblt52QtidkWxOPXJUlBfnQ/rDO1d9BXcBvB1f6zaO5j0LfHGjIua7dtmOEC+fa
	neVgQS5+otpe5uI5mrtcKlVbw5DSEbV9KXE40zLgv48IXVwcSNlCgb6KwpemsrVzi9JhrL
	d07FX3hgqnm5CMF9OYGDGza5/6oFlOx8CE5+ZTbgdU7yID3LDaV+9YsVpxmFVB9jkOqxJY
	IqPUQYVrZF6c63VzXOGFeKDPG67J/hyrpVZ2gj7cipxwGKjfu+9bWrVt7N6lgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794848170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDsIwsWu1KfQS3Aqtw59xAzqiLwWxmSzDSkW35hSn/U=;
	b=e1DFnPa7JHJPmVtStbW0ulMaQP6TI4B9OVTYKVGf+WNc5CrKG4/2wIDCCiE0jqn3cpIQF3
	t8hYYoMxdAHHpmDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/5] selftests/futex: Test priority inheritance on PI
 futexes
Message-ID: <20261116165609.RMK-DX1Z@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-5-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261108141347.1525532-5-mathieu.desnoyers@efficios.com>

On 2026-11-08 09:13:46 [-0500], Mathieu Desnoyers wrote:
> The PI futex selftests check what FUTEX_LOCK_PI returns. In these tests,
> the owner always sleeps. No test checks the priority an owner runs at.
> No test waits behind an owner that keeps running.
=E2=80=A6
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I did play with this and looks it catches the errors you reported/ fixed
earlier in this series.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> --- /dev/null
> +++ b/tools/testing/selftests/futex/functional/futex_lock_pi_inherit.c
> @@ -0,0 +1,773 @@
=E2=80=A6
> +static pid_t sys_gettid(void)
> +{
> +	return syscall(SYS_gettid);
> +}

glibc-2.42+ has pthread_gettid_np(pthread_self()) but this is fine.
Debian Trixie has just 2.41 which is a bit sad.

> +static uint64_t now_ns(void)
> +{
> +	struct timespec ts;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &ts);
> +	return ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
> +}
> +
> +/* An absolute CLOCK_REALTIME timeout @ns from now, for FUTEX_LOCK_PI. */
> +static struct timespec abs_timeout(uint64_t ns)
> +{
> +	struct timespec ts;
> +
> +	clock_gettime(CLOCK_REALTIME, &ts);
> +	ts.tv_sec +=3D ns / NSEC_PER_SEC;
> +	ts.tv_nsec +=3D ns % NSEC_PER_SEC;
> +	if (ts.tv_nsec >=3D (long)NSEC_PER_SEC) {
> +		ts.tv_nsec -=3D NSEC_PER_SEC;
> +		ts.tv_sec++;
> +	}

This breaks if your timeout is something like 1.5s and ts.nsec is
already > 0.5s. We usually do
|         while (ts->tv_nsec >=3D NSEC_PER_SEC) {
|                 ts->tv_nsec -=3D NSEC_PER_SEC;
|                 ts->tv_sec++;
|         }

and in worst case gcc does a div. But other than that=E2=80=A6

> +	return ts;
> +}
=E2=80=A6
> +/*
> + * Start @t and wait until it sleeps where it blocks. Return false if it
> + * could not be created, if it failed, or if it did not block within 2s.
> + * Unless it could not be created, the caller must still join it.
> + */

Could rename it to start_pi_thread() or pi_start_thread() rather than
just start?

> +static bool start(struct pi_thread *t)
> +{
> +	uint64_t end =3D now_ns() + 2 * NSEC_PER_SEC;
> +	pthread_attr_t attr;
> +	char state =3D 0;
> +	int err;
> +
> +	pthread_attr_init(&attr);
> +	pthread_attr_setstacksize(&attr, 64 * 1024);

it makes me wonder what you did use as a template for this or who wrote
this. I can't imagine why one would set a stack size 64KiB here.  It
shouldn't matter.

> +	err =3D pthread_create(&t->thread, &attr, pi_thread_fn, t);
> +	pthread_attr_destroy(&attr);
> +	if (err) {
> +		t->thread =3D pthread_self();
> +		t->err =3D err;
> +		atomic_store(&t->done, 1);
> +		ksft_print_msg("pthread_create: %s\n", strerror(err));
> +		return false;
> +	}
=E2=80=A6

Sebastian
