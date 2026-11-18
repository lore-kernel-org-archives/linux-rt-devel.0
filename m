Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019893;
	b=xJt9J9B8X/E23YSebLO84IK/5zzT18sG4w067vEU8pBK/adND6svLo+94gtAYlxucQjk
	 yGzQMvamjvmmCC3EhfU91y1S6bUh3RyIr/1+LpXXccw3RGoXY0KRlfuS/6bRhXC1ZaNyH
	 2VQ7V/9Qv2DlRk3/PyKsUV9E+ku2RyQFMouvW6pfqoW+/A1H0Ru0Rm+7Po5dYAaTn/3Ol
	 lsycRSjCZlYJeTJFMnFfWXSCXc3ytG2ENz+DtvbX3HtJSmgz3/QxG3AjocLZwb1u28lKu
	 osYWmhTnsZoCVEekqZdFge0wCIGzUaFZMRo3DhdmMVuYHCz9IQv3LIDYK4gX2LrOIcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019893;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=V7mJeiSJCVTjraIciJJrP4E+euyuUY8Iim8ikHfaISQ=;
	b=jJ2BLpd7CKKsBbN0RJ0Ho3luf/eJD5I1qWmxf1KskWK0d7J/ENzNAIR0LvX/XxsiYGQX
	 O4jAAJGbcknJ28pY1JQxH3CdW17uGJJ81oha+hw5MpMcZxDDKuesdlUEC2bJTZz1I64P9
	 CCnz0McCOk/zcaFhwv6qOE2FB6l8cNmmwfOy4fMszoL43uCSHZrvR5rQ/MNoQ+ERIkEaW
	 1x7zmhQGKtYlqCBeHId49us6lOPwoJNteiaFi7asRzefuugnJdTprKfCCvF81DOZA6pAH
	 RK9X5i805C/UhLzJd+nUBf/7jeTsuqMlU51aEzhg8e4Te/B54pbushBXuzvUN25qDtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uK7X0Dfo;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xPoOYmXL;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F57606A31C
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 16:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F57606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uK7X0Dfo;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xPoOYmXL
Date: Wed, 18 Nov 2026 17:38:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795019889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7mJeiSJCVTjraIciJJrP4E+euyuUY8Iim8ikHfaISQ=;
	b=uK7X0DfoIne69g0yXQMBSJNgig84GmBBKama+JLaaIgkazJp4dm7/JhP9xlkk/EJkg6Kxk
	uTdLoXMhELgIzbvQIvq1MqK2XRP9hqqJM+3p0KvuPyx//hnV/jjPrhVivmyKDWzKVh0EuO
	C53YdqQSxGuFeE4eMegPyfCPckZS3M8NB7GrdOgBZbtQdzFEsTZqehRxJjiWw3MPhHxrdA
	YyAzOR2mMVZpe3hgXacPfGVHQJn1uFTNxbAqoEMheYzL1D2Tekn1g0mUz1L/7ZFBhtNE6d
	jYBfTdk/WzeKpJQ8usQrFm2odvYdCflhH1MYhvvDGhL1OsNDo5RYMlokrvDeew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795019889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7mJeiSJCVTjraIciJJrP4E+euyuUY8Iim8ikHfaISQ=;
	b=xPoOYmXLPL31H1HUpE17x11g4ZXHh1c+tvwXldjILuUsoFXpNOMA66/hVut9Cb8dzQKDmT
	ZgYgAMbg/EqS0cAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 5/5] locking/ww_mutex/test: Time an ABBA with both
 owners running
Message-ID: <20261118163807.75hxTxGn@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-6-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108141347.1525532-6-mathieu.desnoyers@efficios.com>

On 2026-11-08 09:13:47 [-0500], Mathieu Desnoyers wrote:
> In the ABBA cases of test-ww_mutex, an owner never keeps running while
> the other context blocks on it. With PREEMPT_RT, a ww_mutex waiter
> spins while its owner runs. The wound that resolves an ABBA reaches the
> waiter through a wakeup.
>=20
> Add a wound-wait case where both contexts keep running. Each one runs
> on its own CPU at SCHED_FIFO. The younger context holds B and blocks on
> A. The older context holds A, then blocks on B, which wounds the
> younger one. The older context must get B within 10ms on average, over
> 10 rounds.
>=20
> On v7.4-rc1 with PREEMPT_RT, the case fails every time. The two
> contexts spin on each other until the fair server preempts them, after
> 950ms by default. With "locking/rtmutex: Stop spinning on the owner
> when the waiter is woken", earlier in this series, the older context
> gets B in microseconds. Without PREEMPT_RT, the case passes with or
> without that fix.

This is the ww_mutex equivalent of the futex case on PREEMPT_RT. I got
lightly distracted by the -35/-EDEADLK error it always returns.
Something that we might have since v5.16-rc1=E2=80=A6

Anyway.=20
Since both (ww-mutex and futex) use the same code I am tempted to say
that one test case might be enough.

But in case we want this,
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


Sebastian
