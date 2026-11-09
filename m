Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243894;
	b=fM4f/dauqkL4D+gm7ByUYWQrxfTtnQJ1GLLJJZO5XkZysa3y5qWcY+taGab800rLGpDl
	 81LKKuiyOHWbJFuogzsl4ZpjLpu9eKjgDvlh6C/t/SDtwoHFuCGnTIU/UzaTdLMzVEAfB
	 KwDkcnpaeZ1rlj8STX0tPaT19EvIsb/ERRxQGhYj12V4pMYIALJVAcw9F7qYH0+Q9PgLr
	 nM395duNMWTojPT+VbxJgsktc2JusSrfF/9HdxSfhzvjs76V2riv7ynTk7tpLsbrkuTLz
	 MqguIHeIRHDgi0Wz9m/YhmtW++oMtcrOnpv4pXZ9wf/w1+I4rd/PmBTjlWj/GPoRavQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243894;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=93TBdXA6VfwaeFyOsaksO5eGGGBGxnvWIH0FYk6LMa8=;
	b=dw93vPVne8XQ28zdkJ7TWW9wRUENIX/AQguiuk0BbyBny6fyURuoYpAEeXzt++8lH9/h
	 4LIKEVQMvqeOW2tzaW82iBFLPHyI9MPwsEDevHsJ7WY7yLG82g5Pr+J9OXVM+Vf+CY9wN
	 MfS1AqubWYLlU4FZ2shq993sRM5psJyPwxDLlIMihPoeLtAfSJ3MwMKnRxtFNDJvG9fSU
	 5hl86Zlp5Px9k9ll1xUkN9LMaTt5tF7tAdjrRjW9hJ8+ltDFpSHX+vD4Mq2WAvKhJzbr0
	 MDXCe4aCOzAq4VPRmyvxgwtRHdZo42hvt5x/tpT/6pmgVdL619z4h7R4leOSfLzBfzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RN+oHVFZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=35fhVzPt;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD204606A326
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 17:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD204606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RN+oHVFZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=35fhVzPt
Date: Mon, 9 Nov 2026 18:04:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794243892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93TBdXA6VfwaeFyOsaksO5eGGGBGxnvWIH0FYk6LMa8=;
	b=RN+oHVFZwQ2NPQQk9VOl1tZfMbv+3RmVj2ko/T1efzO8XsZmrAZa8Y3eyyZEr5nfr38tdv
	KEnB1ufoD9n6eY1ZtYptaPnAHf/oW6zuC0U84UAKZ9VGDrzAmpT/5jaxJfYjAt24ys8jH9
	Nc35jtRE/0Yg42oVdhnkwqhMHT90HOjCif5W8ZeEQVyeuK9qSKWhmtc4G79poG8gpiUOXL
	M0at766FG1K1sLfnrKC8F/RMVrcZLJY4nWVqVNWAkGgT87GdLq7OMGgtlxhA5b3/24GpZz
	yLjZwSAoAkOMpFM+IdIUM+1VWRRkamtIFpvHoxU7ZvtSlPo/weQrSSOAMtl5yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794243892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93TBdXA6VfwaeFyOsaksO5eGGGBGxnvWIH0FYk6LMa8=;
	b=35fhVzPtetsHVOTgVfJ+fvDbzOaNXhaTQrfRJG+Usykq5mzxKHaXLskP3dT/cqhCk4X4du
	wjp1q/3bgb8sQGAw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Julian Braha <julianbraha@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Nicolas Schier <nsc@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, arighi@nvidia.com
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <avH9Mo05xQjv5wYq@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
 <20261109003745.GA3429615@ax162>
 <avHxmCEdHgyRD7n0@lx-t490>
 <20261109165230.GC1608140@ax162>
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
In-Reply-To: <20261109165230.GC1608140@ax162>

On Mon, 09 Nov 2026, Nathan Chancellor wrote:
>
> On Mon, Nov 09, 2026 at 05:15:20PM +0100, Ahmed S. Darwish wrote:
> >
> > What about kconfig-audit?  Something like:
> >
> >    ./tools/kconfig-audit/audit.py -c .config -p preempt_rt
> >
> >    make POLICY=preempt_rt auditconfig
> >
> > config-policy-checker does sound good, but it feels verbose.
> >
> > Feedback appreciated.
>
> Yeah, config-policy-checker is a little verbose and might not translate
> into make rules well. kconfig-audit does not sound bad to me, especially
> with the rename of RULES to POLICY; at the very least, it is on the
> right track.
>

Thanks!

Then, kconfig-audit it is.

--
Ahmed S. Darwish
Linutronix GmbH
