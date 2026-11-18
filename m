Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027536;
	b=NUtxOuxsYoI6EC6OddtIC2TII82vSJ6zoJHWh72Ru8HuevO98w4Qr13taEpatK/Uswu6
	 AkvO38RRA9gCeWMmem4oW2OymIJwFCT9vXOyQMxXQ/uzKgDnYD9Rgs3CB7rkLm4/PHCgT
	 DAyGo+MZ5jtbVJ/xl8kqZPbGxcQtO1iIsq4LjG6mHui/oxTpATBolF7e9ws6brVdFEcdN
	 2aAIFFY4eVjH4LitDHsajT9XEKRcMTVanS76J3YMPq/xY6vlIO6P4O2dhURpcqGdLGXzt
	 2hEdhMJIXGNRau2N2kaAjnTGKGfhHneEN6JZ0c7lRTZTcHsRDIWurS9Mo/yIvPEWPEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027536;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=vGWUgyGfw7j22BMb4pU06ctXkLaCqXf8bR6lTYcnToQ=;
	b=veLyKvdbT8KaHtHp285RFDq+FtIvTiyu35dGpMPcUgohY9NQzl6hw1j58nI8r6m+ekkV
	 Vhem52xRdtruhVnJyWewPy8oNRt3elD4Fow298lddaG7406BCSekZulKKarR/isuAESX7
	 +YekqSLoHmEbONtXNL9JRX+YQwodzdHjGtcuXMrAptImqs1Rbt1vkwc4JRX0wyndHDxKr
	 lxbQr5QzsmkvUA6G/QZiLQ0oOPJm84hFUxXRxquCcra7XgvDHj76xZeC5jPAN3Lf5/qB3
	 2scqhp3nLj2NuyR/TD4+csDHrPDtZm0X262egJll0RIrPCHKsn/HnCEm3/u9ZiBS2rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IQCQA2zd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=IB0tl0dO;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC960A2611
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 18:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06FC960A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IQCQA2zd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=IB0tl0dO
Date: Wed, 18 Nov 2026 19:45:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795027526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGWUgyGfw7j22BMb4pU06ctXkLaCqXf8bR6lTYcnToQ=;
	b=IQCQA2zdkTcf9E6mhzzRMaLYIbiNdjO5KRf7VnD1VGfQrT6qv3DniWkbigfsq+bhE6Tujk
	RrogTYi0aSVRHhW+5nEICKshtgXZ20WtT7qg76ppTdO/A9i69qiyJmz6EOdcL/CDrqbKl6
	RO5pEABTAuySwUj8DFCvw0Uju+upOqm4vWES9HTXn0F67xMBEkb/G5w6AVBGg/2hLlwcgK
	w8Q0kxcrt8oqGQUJOyp2nN68x+Uy/nby68mlXbMYoltILfitXFV2/387HEW6HseduaC4Gw
	auMtX0afIROcw0m2kbOpTHB0HEJe4ZzBscTzHUsrwHpQIdRKrhzK6sznwFM7nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795027526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGWUgyGfw7j22BMb4pU06ctXkLaCqXf8bR6lTYcnToQ=;
	b=IB0tl0dO0GEA+iI8A5RmjHEUCuLm9UMaL/bBsKz0K1j3Ghz/dISF3vGZHh1wz6CpgDAsRt
	C1fdWc9vPTxswjCw==
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
Message-ID: <20261118184524.Vxz_-nKr@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-6-mathieu.desnoyers@efficios.com>
 <20261118163807.75hxTxGn@linutronix.de>
 <e57bdae9-4f87-4cc1-9fdc-22c2d766e252@efficios.com>
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
In-Reply-To: <e57bdae9-4f87-4cc1-9fdc-22c2d766e252@efficios.com>

On 2026-11-18 12:29:55 [-0500], Mathieu Desnoyers wrote:
> Hi Sebastian,
Hi Mathieu,

> > This is the ww_mutex equivalent of the futex case on PREEMPT_RT. I got
> > lightly distracted by the -35/-EDEADLK error it always returns.
> > Something that we might have since v5.16-rc1=E2=80=A6
>=20
> Where do you see it? In this case, the younger context gets -EDEADLK
> from ww_mutex_lock(A). That is the wound: it backs off and retries, and
> the case returns 0. In our PREEMPT_RT VMs, test-ww_mutex loads with 0.
> If a case of the module returns -35 on your setup, I can look into it.
> Which case prints it?

The timeout that was introduced in commit cfa92b6d52071
("locking/ww_mutex/test: Make sure we bail out instead of livelock")
triggers. That is not related to your patch. Increasing the timeout
makes it go away. It takes ~7sec to complete. It is not related to your
changes.
According to the history it hangs on real hardware and passes in kvm.

> > Since both (ww-mutex and futex) use the same code I am tempted to say
> > that one test case might be enough.
>=20
> The two take different wakeups through the same spin. A timeout or a
> signal wakes the futex waiter, and its cases fail with and without
> PREEMPT_RT. The wound wakes this one, and it fails only with
> PREEMPT_RT. I would keep it, but I can drop it if you prefer.

The testsuite changes, without the fixes I get
| [    0.810516][    T1] Beginning ww (wound) mutex selftests
| [    7.388445][  T143] stress (stress_inorder_work) failed with -35
| [    7.410548][    T1] Beginning ww (die) mutex selftests
| [   13.994648][    T1] All ww mutex selftests passed

The ww_mutex testsuite complains only on PREEMPT_RT. The route cause is
the same. I don't see a difference on !PREEMPT_RT here nor do the
patches touch anything.

I don't call the shots here, I just explained why I don't see this
needed. We might want to cover this code path if the paths divert in
future.  I don't know.

> > But in case we want this,
> > Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> Thanks!
>=20
> Mathieu

Sebastian
