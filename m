Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342803;
	b=ZFMRE1+6GyRGG4zddNj2HXeBWQwefaFshdBdfHfIFFX68qyTQp9SMjww2BPEf6MWL4z8
	 O+zF21WRl7eFckVjR7sYNiUkaI2xZTF+gfPDLqMDZr1GruMO70wUBmDVoNwBwlz17cCPv
	 wmoUqZlKd1+iozClO+/XosLiLgqvt8tZh8jgE5jfeuFUEpvakYxTqyDiyo/R/kMJjbyJC
	 zKXOwSoKUqgyxakYUEsAf7lCEhpmjtO1morB/8G+/tkNq62448V5Wc3yCUAaxfUU1N2TM
	 OumST8vDSjZ7CjxRc/jUEzh52CTC8vgBW/NiL2zyH/isI6uZ2jrJVXZxjd5UX5F8bNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342803;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qgTKR/FH4Odf9egaKgFSB+FS6DwQ8nI7QRh2NSJgel8=;
	b=W7DkKVi0CK+KsDzwSp4/Qf7O2CPWpKi85X0VICKCJ0oabLU6JD7cFoaLBnHya1UI1CTn
	 5vYG3YFBe3gBX0pHGeI1Nedik1fJ8+IMdI0WmGo19AT70lgoMxpBxHB+QHB1OUdWQ/OQK
	 YIs6qoVtPcL0CbjDDj8svMg8fcZMq2S6MppqcV+wjRnSep3rltUj8N2/4NT1VKvznMt5I
	 QjEMD60L/xrwAm20UmXA/1s6ikZwu0iuzUpcbLU7FnnOyYtPtUAwdHhYRhxkj8IObt06s
	 FjbU8S4SqftoKz7op1y9dw1vjk282TyBAxBzQwgDpydukKESMZnU/000wg6fJZWWIbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jVEX0cPa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xZ1GCxt8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD8606A31C
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 20:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBD8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jVEX0cPa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xZ1GCxt8
Date: Tue, 10 Nov 2026 21:33:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794342801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgTKR/FH4Odf9egaKgFSB+FS6DwQ8nI7QRh2NSJgel8=;
	b=jVEX0cPaFlxBvXXYB+czWXU0erwrtCmM9sZLs2Jutu1xrqpXv74ZeYtvcuTH9LD1ucheWf
	Py97rMQTsPY+RrY58menLGqg3D1FDnxbK2zfZVNdPOirKdGADSkZY4WKobTGHI/0BsSB3V
	/TLozkp8CsNxdoleX6QSP/NF0C/GuoEjQBShzwtRM0k3QqEvqASYTC4pUbbHJgpCMn+l9c
	IwO7zOZXekYsQs7zalsF1MnOz9hSVuEX7N8fVIQI8xG7rRIUbwBeoBhDNq5yICLG7lh4zU
	hxjEKJhlIUz1TfWpGy41TszdPWqyZ8OEqwCN6qnPr0zlx9xB7FZ7wSgi1TJGJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794342801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgTKR/FH4Odf9egaKgFSB+FS6DwQ8nI7QRh2NSJgel8=;
	b=xZ1GCxt8tXPmk0qC3Z9b5l/3G6MLfqduPjTEaxGwM53vrt+Vd6ThsS59PMscr5/gCB/Wfm
	cW9W/KDf5TsTZqCQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Julian Braha <julianbraha@gmail.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
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
Message-ID: <avN_juQm3x30nP2n@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
 <avHroNa1vcxmCIOs@lx-t490>
 <c0ccddbc-539c-4987-8685-ec996285f746@gmail.com>
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
In-Reply-To: <c0ccddbc-539c-4987-8685-ec996285f746@gmail.com>

On Tue, 10 Nov 2026, Julian Braha wrote:
>
> Yeah, Annotations also supports generation with --export.
>
> But it does support validating a config with a policy using --check [1]
>

I see.

> Anyway, the point was to provide context for the maintainers that this
> problem is bigger than PREEMPT_RT. I want to see this functionality /
> your tool in upstream.

Thank you, and I apologize for my defensiveness.

--
Ahmed S. Darwish
Linutronix GmbH
