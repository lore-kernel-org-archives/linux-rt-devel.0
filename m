Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EE343892
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644455; cv=none; b=S5BlcyeuSE7nQjE/Apm+aPP4hdra/nxhexDrANd0b9ph86e2co8GfF1frKCOJdfedyflysb17InE4DwO03J6r99QReGMvZihuRHBKXArLEH8GfEbOBh+yutxLGeBREsnHbg/o2Xz+q97usLJniUvQmBLZ/jv64ksj4xmM+RN89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644455; c=relaxed/simple;
	bh=AgsLMJS+RY+/uSh7mWQJdFuvnG6r8dLIYywbCiSc6eQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEIi1N7sosAAy/lMwnwS3JPMHadUvRWVHLcdZO+bblACPKLYlObQIDIZ7lxcvJIRt8Iut8jEUhv1r+LSHdKkleZUYvWV9yNnNQmvtYHAnFjFSJ0R1wlNCywktkXJzra9Gb9y45IL/nBlquygiPDlbd0WiZRT9whnJrYPTo5Y4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlsUt+u0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ed8q3Zr1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlsUt+u0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ed8q3Zr1"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784644450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDH4zoXVV/yhbssXbzbZd/geh7UMlePs0Qre6oI/dJo=;
	b=KlsUt+u0wMIftRZllTDfBHgYV5gV8Ht4W06iQJXMEggSwwaZQOcNIhP8zrrLhF9nQzFcl1
	G6xVoZSuWLOy0aQK0gUuNgQsDBMoFB2RihvVl6LfUmiExDwGAgGFwGumR9g5TF7IZZjnC4
	5LpAW/FBikx063BeLBzDY23EFKrkpYukS0kwgiZxerp3LdtsiiYhwDDXgI2Y0fVySFDq56
	83S4+IDwJIwB9ndu/D1hZlTaBHLnK+kdL2opRvDJkut4LkKQQVqPCWtTL/0Oq6NsvS3c4i
	jzyb2MSQ0gfqGJC2BFW6g9lrEwOtMoygTz38/n1ZPSrqgSYbyRPalqAd1kDNDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784644450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDH4zoXVV/yhbssXbzbZd/geh7UMlePs0Qre6oI/dJo=;
	b=Ed8q3Zr1cJ3M5iXh2YRsAxB/KAgMzVd7jpmGOm4ajR/AWTNhKFUOmp2lHk9UAqMgkSCMGn
	CuoIy1SfxfYvxXBQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Ahmed S. Darwish"
 <darwi@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
 Matthew Wilcox <willy@infradead.org>, Derek Barbosa <debarbos@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
In-Reply-To: <20260721130248.ndwsFtHE@linutronix.de>
References: <20260716195716.256025-1-darwi@linutronix.de>
 <20260716195716.256025-2-darwi@linutronix.de>
 <20260721130248.ndwsFtHE@linutronix.de>
Date: Tue, 21 Jul 2026 16:40:10 +0206
Message-ID: <874ihs5s4d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-21, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> +``CONFIG_DEBUG_FS``
>> +^^^^^^^^^^^^^^^^^^^
>> +
>> +This is safe to include in real-time kernels, *provided that debugfs is
>> +not accessed during production runtime*.
>
> It is safe to have as long as you don't use it.
>
> I would drop it. That filesystem is not dangerous on its own. It depends
> on the options you change and how this affect the system.
> We used to have it always enabled because you needed it for tracing.
> This is no longer the case as it has its own tracefs which has its own
> live outside of debugfs. So I don't think it is needed to mention it.

Unfortunately, debugfs is needed to configure the fair deadline server:

    /sys/kernel/debug/sched/fair_server/cpu*/runtime

John Ogness
