Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441F3AAF42
	for <linux-rt-devel@lists.linux.dev>; Thu,  1 Oct 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840388; cv=none; b=A6E7ejRXfMZdkPCITa7821NA1dhwGKYxojr/3ruRqxMEFGGxxa4iDO3yWhpkKesyfOtEEqS7tlqTUcgJLS65za/eaTrS3MjRG9GZ8EisYrlNRGLlkKVj7HhEXgx5qw6t6YcwNaDJPrpgyHbzvGHmlQECFpBuBGnjPiKVP10dhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840388; c=relaxed/simple;
	bh=55sRFBGXFDX+6ubexTshVbi8YoYaQKcQK4rdcq3wsM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbYvlLUrKvLeG/9h1A/TC3kjztB9DgN71FBiAOaLEFkfnNWxuhqhTHsfN2SKnykSzDEGbERU1voi5UKbKnXfVzAEolGf3eqAewfATGLb1+JM4p/0FED/l2w85cp87ZLbiDe1lpbKp8RExw+3VBj4uno4rAZXzctXmi6cp5NMCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H5ADH4RU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LC849Svj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H5ADH4RU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LC849Svj"
Date: Thu, 1 Oct 2026 09:39:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790840384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55sRFBGXFDX+6ubexTshVbi8YoYaQKcQK4rdcq3wsM8=;
	b=H5ADH4RUxK1UUoCugVGup5Od1rW0g2NXlzeoTkKVpAxz91t3nYV3qI6ROSzssSNAldaySH
	mTq7yTUu2It3ZLM+NsxIsRaGKaADs7CZrRZ/yUVakS3JRldvSFUSxKpy91H2D++i5tpjn+
	/M4IQc5j2DPA8TJUAEBdboQY4sJ6j1hhvKBFPq1Er2y3n7mCilD+fz5GemnU5/g/Fl9kzv
	tugJLt8ZGW2E9wtM3cV8gFlHNzf7q4Q0eVcb0nyi+EneWWpLyhdH7yGgygqMjkXe1BYVtY
	MN3b78fxMwpJr33BJbxf/ooogYqCQZKLFGonJQFveJVOfM+bCBU3WbGe0Lzu1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790840384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55sRFBGXFDX+6ubexTshVbi8YoYaQKcQK4rdcq3wsM8=;
	b=LC849SvjZAxpKGaUQHVRpa4VX/3KdlvOFZ+Znez4n6SWj5oGojEbFVtB8uTMx5T5Yy04E7
	cH7HenTyMsrJerBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20261001073943.QYhian_i@linutronix.de>
References: <20260930191432.62760-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260930191432.62760-1-kmehltretter@gmail.com>

On 2026-09-30 21:14:32 [+0200], Karl Mehltretter wrote:
> On the return from interrupt path, __irq_exit_rcu() removes
> HARDIRQ_OFFSET from the preemption counter at the very top of the
> function. Everything after that reports the current context as task
> instead of hard interrupt. The code in the function itself, such as
=E2=80=A6

Good.

Sebastian
