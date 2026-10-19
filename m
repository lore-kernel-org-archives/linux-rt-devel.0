Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435844;
	b=lnlTDueXXepBi4uCujEwet6HlDkik1cMOMP7wpMm1BaneSI1sWsxjMgzCzv4WWouYgik
	 tFav7zoaIUloN/8+oqTCwOgJrd8t/WWOPQWSXdSWdAlurlOyecH5pXh00y5NHgGCGh55I
	 Bl1AhOXveEBGdN7b6AnbhdP5vyy64NBOSDYsAc5TfWA0nA345zqUK4bQAA0CQzvKzBSvZ
	 VEf4sa5PJ7KWfQ8KLWUlCZrZXIAPtvUqjGfSizGxDSdlRLc/SgZjTaisAvTlDFdIQMgm7
	 d9VQxxc6LYDGo1U8oAAOvQFmWLidGL0xOk6rNIG08S7D+2vUaaFNg8cljVR33HztXjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435844;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=te7dnZaa4V08cysI53I143BMOqDKYxG1tFa7yKmC0QE=;
	b=xF81lrxrb+jpqzkwITwKJTLUDqts4mcyq8UxqPDh7BDGClJsV45SlU6KkpS7L9uXLssr
	 idfyWMbT2OOiR9ZjX5jMxMJzxNx4OcOgz01GjusjXEJ8IImei36vg7qljJNKzHzmTGJEO
	 LScFU8TcxzHs9e6Jwir4XCOa4ponufVYbSfSSF2yG7JactS8UbUwGK7C92DLRe4fNscF5
	 khyNjHn6NsUANRxuLp1kimLKuU32vYcVuZCCM2YpSc1MV9FhN7AxYhobFzBrx86AHLN5H
	 DJfQyg3XAMKCfa5sKDeO81BX3m2ESmcEEISZ350KEwU6z8XBbhrEzjZBtcGA0YqRb9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0scKJem;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC4606A319
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0scKJem
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3741F000C4;
	Mon, 19 Oct 2026 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792435844;
	bh=te7dnZaa4V08cysI53I143BMOqDKYxG1tFa7yKmC0QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S0scKJemeKU+T2Qxtr+EjHGVNTXE82/CP6bfjmgJzjNuKFlzgsOlFVQLOnt8yv8Px
	 Qrtj8kAgiIkKxDEnBZR7Y2CdwXKQPXLjeBWgiwqZYCgOCRP33/RNXWLwRZPOfVTNuP
	 D0Tlp8gG8gJCTInQrDrhcxyOm7qDeM1InLHs4FdChayOXeK9KDPmvJD6ZG1OZfzdM3
	 4aYbV/T6nhCpnQ0XXwDnkeg3KTtvzKTkBC9CIvquQL3rS8Hhd8vwIdTHZ0y9P/JKrJ
	 hNEI0UUo+DwucCTyPpiiVqxAAopYOPWsE35XdzEgZkscclhVqNXcJnuZEnyKJAAMpZ
	 MLn0XYwPXZWtA==
Date: Mon, 19 Oct 2026 13:50:42 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
Message-ID: <atZmgh0uq6sTdWTc@demetrius>
References: <cover.1792345413.git.wen.yang@linux.dev>
 <atYZLK0gmG8vRHxG@demetrius>
 <b957b12e-f272-4dbf-a308-c6b61bcb3d66@linux.dev>
 <atZWIBciePyeMnWa@demetrius>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atZWIBciePyeMnWa@demetrius>

On Mon, Oct 19, 2026 at 12:40:48PM -0500, Clark Williams wrote:
> Meh, 15 patches doesn't suck. I'll try and get to that tonight or
> tomorrow and see if we can have both v6.6-rt-next and v6.1-rt-next
> soaking. 
> 
> Clark
> -- 

Wen,

I was reading back through the threads and the previous series and am
confused as to whether your 15-patch series has all the RPS code that's
required. I seem to recall Sebastian indicating that the original
v6.1-rt patchset needed some extra RPS bits?

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
