Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027913;
	b=PgcB9nnT31AM9PAQOqCm28EzzyeSYf+b++2T2fazA6XP4gKzCi8TIqL/gWB6ZSTXlRXC
	 6vx6rZRwqxIKwkCkbU7CKnz3vItZjY6ZgTzHl+8iMwUQegg+gJAMQCixUKa3HBNVT1c/S
	 QgAJ6rrOgFLanfr9VVuBvsbpH2HDXqM3XIRikIxPaL/PdXyjageBDn3QArrVlfS9BLlnS
	 H5rhLB+iWWHCsCqHitVCqW2SlS3YOVZJFV13qbC0i4RHwcZcABezA6bmHcXwV777cA1C/
	 WAaUih1EN+P0a7VD+NY7P17vN7aF8tUAXpd3fm6tXuEcNZHhfuIWkr/iQ4+ja0IVXqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027913;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7r/uBMtDqbIiez9GoW6cYv6uWC8IZHkqEq27b9GWd48=;
	b=jnhkEzzW05GcMJJl0q+nhzXy8nPFtVViluuH8e4h+i9eejzaUG5Nto8SDJo07gIk/SM5
	 TkdZrPxA0eOJyr48PN/koOt39DdfvlyQwKc+0+EaYEotsJdE4Uqqqh6UnCVhyPuhd+p2O
	 /9MqBHQsiJnECvihukKwmttnt9hjRmoS+GtbAZeWE63so2Nd79Z8BplclE5W4pwZOPNxE
	 Biw+YODenNHfyVm1R+I2seK9THbg1j2pdG3P3rWI58elgZzT6aefP/2XD2WEBk3Ok/kpF
	 od4O/d3ecEBKHdZ8ytH9scKjoLZPyKJ5hNS8VBw9te5ZlS7eSlZPB1n+bOyPY/NtXTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2RU5uVqF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KyuNyxSj;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5CF606A31C
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 18:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E5CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2RU5uVqF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KyuNyxSj
Date: Wed, 18 Nov 2026 19:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795027911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7r/uBMtDqbIiez9GoW6cYv6uWC8IZHkqEq27b9GWd48=;
	b=2RU5uVqFIoOcYBIuu5FzLeZm4jsbablm0hI6vBLqVKkE+t/H2MyqhbMaMR2PndJTE/aUem
	VHULrJ2Oi05Ld5cpNiU9InhF4vjDQGSJ690omV224tEOb6J0YH6hPlBYxtTOXoOK+ur8Gu
	QJbO5uBST6MsWBuBe1aagO5n9FXScXVlciDPXxN03nku1zA8beq6uXbW/EaKff+tbfNW17
	glFcYsSbmDTESwrioWz4qaBO9M/oJpV1UBY+TrFpP6TygG4VbGrfbyFMuyy/HL0WdjCoHG
	qOnG23Lrx+4w0qgVjQIOMuWMJoC/JaZ4M8FRfF52slHZm4Sqjp2RqsOhL1F6fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795027911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7r/uBMtDqbIiez9GoW6cYv6uWC8IZHkqEq27b9GWd48=;
	b=KyuNyxSjVooS0IRzd8hhn0GsDj/vn33Jl75FyYQgzq6P7APeAp8C365+D10R4taBEmalQt
	aPDusTuQ6CFwBYCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] locking/rtmutex: Stop spinning on the owner when
 the waiter is woken
Message-ID: <20261118185149.SNIpxf_4@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-2-mathieu.desnoyers@efficios.com>
 <20261116120626.JVHxeSTu@linutronix.de>
 <83330898-b6de-469c-ac20-7367c1eb4f0e@efficios.com>
 <20261118141912.GnOg6YYM@linutronix.de>
 <8ba74adb-b8c4-4109-b20c-7094012d4853@efficios.com>
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
In-Reply-To: <8ba74adb-b8c4-4109-b20c-7094012d4853@efficios.com>

On 2026-11-18 12:27:45 [-0500], Mathieu Desnoyers wrote:
> Hi Sebastian,
Hi Mathieu,

> > > I kept the check for TASK_UNINTERRUPTIBLE on the rt_mutex side. A
> > > ww_mutex wound also wakes an uninterruptible waiter, and the ABBA case
> > > of patch 5 needs the spin to stop there.
> >
> > Not sure what is related to. I don't see this in this patch.
> > TASK_UNINTERRUPTIBLE vs TASK_INTERRUPTIBLE would make a difference for
> > signals here.
> 
> Sorry, that was unclear. The patch tests no state. You had suggested
> to limit the check to !TASK_UNINTERRUPTIBLE. I did not do that. A
> ww_mutex waiter sleeps in TASK_UNINTERRUPTIBLE, and the wound wakes it.
> That is the ABBA case of patch 5. So the spin must stop for an
> uninterruptible waiter too.

Ah okay, that makes sense. Sorry for the confusion then :).

Sebastian
