Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A82727EC
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611385; cv=none; b=bKKcFXNIzkD/GpI/SfjPhnebUzX0Gf2Z/b609o1kOQTIBEo9PkOLxulPiPjM8zNnTTiWlGTDORXTrvytFlaX+s8xYVidxqXdzSUTzxTbursTzNqo39oGKPBcp/H39bGBR8oAl9cEj1lVzlckm/PgCTqVUgh6tJ5UZF2LwWpHCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611385; c=relaxed/simple;
	bh=fTn/QgTpFX9o7jIW4pD8Y66/xz/PwefuPE5XYeqm4Ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ij+bJ35i88RoPR4o5TEr5WgVYhNKEuKvqfYXsZ7unUwRPk9CMy0+eKCykGCGA3lPd6o/9geloUFjDrTrN0Mn7t5P0kwUpH8gj3VqtUCAg8irlzoao6DeostYMcOjXZlGM+dlgt/6gGMAR3TSLesvbiKTw9uurDPruK4UFoaNks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HyVPPdJl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HyVPPdJl"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EAB934040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752611383; bh=/LIRBim8AEZq8DekcVe5QLS0RIb8QmJGhFMCCEvV3kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HyVPPdJlRWFWCWAm+2YA4Fv1z77UCgdzze3ADMSzBweuYV1/JigB1HXKvIL64s/n6
	 ErbXFvh/qp3x0Q7aBz2MYy78BZDw2f0CaYzJo9nxCqkWcOH0YyI1NGSPKOkA5b+Rts
	 Zn/UMo4DlZtK3ygOY1FsZ2hlO7yJQUO6Uv2vbLVfmyTyjrnSgNZmjvKO00z7x9NQIa
	 0hlEqktbGUq0/wINHH5v2uTk6+eOFcWvWrYPALMXbJtegRNGQGCfON4tGR3z5PB1Vq
	 b1WhrUM9Qj5WCuWGy4VwA1erXskd++0Joyae2ZWJSf0TXkg7wiIClfV5Yql6HD3iYr
	 HxQHXFvY9rxrw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EAB934040B;
	Tue, 15 Jul 2025 20:29:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>, Clark Williams
 <clrkwllms@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] Documentation: Add real-time
In-Reply-To: <20250715144127.697787-4-bigeasy@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-4-bigeasy@linutronix.de>
Date: Tue, 15 Jul 2025 14:29:42 -0600
Message-ID: <87v7ntdwp5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  Documentation/index.rst                 |   1 +
>  Documentation/real-time/differences.rst | 244 ++++++++++++++++++++++++
>  Documentation/real-time/index.rst       |  18 ++
>  Documentation/real-time/theory.rst      | 119 ++++++++++++
>  4 files changed, 382 insertions(+)
>  create mode 100644 Documentation/real-time/differences.rst
>  create mode 100644 Documentation/real-time/index.rst
>  create mode 100644 Documentation/real-time/theory.rst

So overall it looks good, but I do have one overriding question:

- Who is the audience for this documentation?

I think it's an important question to ask, because something this easily
becomes an unorganized pile of stuff that somebody thought should be
written down somewhere - better than nothing, but hard for readers to
use effectively.

A good first step would be to supply a paragraph or two in the new
Documentation/real-time/index.rst describing the nature of the
documentation and who it is intended for.

Then ... think about whether a new top-level directory under
Documentation makes sense.  I've been working for years to reduce those,
so I tend to push back a little when new ones show up.

- Is this documentation for kernel developers in general, with the idea
  of maybe helping them to not break PREEMPT_RT so often?  Then perhaps
  documentation with that focus under core-api/ makes sense.

- Is it, instead, intended as overall design documentation?  We don't
  really have a good place for that now, maybe we need a new design/
  book to gather such material.

See what I'm getting at?  I'm not saying that these docs *have* to go
somewhere else, but I do think it's worth thinking about.

Thanks,

jon
