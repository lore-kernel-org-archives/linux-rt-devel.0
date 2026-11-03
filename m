Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696403;
	b=eZREf8+M99Ayagerb5AoNIoIjgLx9Ks9rUJqPUXr/r7LaUuzE5vtmR/gU9Da0qIun2x5
	 qA6Jk5gTBPhEo+cGOXO9q7Qg93+QyikeJodWhPoReB8hhOiivU82vvNVmq5iigdi2uZGa
	 jNe326vluQcNx/O6qxnpuyClIiHIn+VMcuNThOR9N9GO0T5dRChbknHxn9ebI07EMqyIN
	 6qLjX2AUaBn06S8VTyFRtjVTvLoOq9+S4H1V4Z8v+ZJBSvZTUm9bv6PAKW1twlZ4nxc0v
	 ATU2VHYgPde+ZBBBh40lf8d7W4FsMlHEnbjCWcSYOJjw53JtRHwYc9QEpPJXttL855w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696403;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QD+CkWG5oyxTZO6V2pW1MZiGJv6VerTZJtv13Pu63rQ=;
	b=Za82GdYv1yWbUJTr7vFugpy3Lhrc1vX68slDi5FZwVvj+iiQJKRohD19mXIs/QYXAVVF
	 6j9jVR7zMcO/PEr2zj7g+tema00ncYQsWDsTliT0pcb71qMW/cTr4Tmffek5dlfCBcDkJ
	 i20Xbiq43aNmsmMABRsHZzSYMDC0jswddNnVnR4+vSa5uI01Rr1TnMa28WPkjY2x72bxE
	 t/3J9XYv8G9JZMy/Y1Gq7CL2YVpr1qM2JfWOEGjrEhIOiNxeyTLgg1eO77Ix+lN8mk5W6
	 LGKw1HAtN7H7nV/V9gytA9BzZL6nAeXnA9T1CCijmQQDeETIveHlWMyyOmbpWeibGcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TZQcwYgH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BkGYvZPs;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9F606A324
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 08:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA9F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TZQcwYgH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BkGYvZPs
Date: Tue, 3 Nov 2026 09:59:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793696391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QD+CkWG5oyxTZO6V2pW1MZiGJv6VerTZJtv13Pu63rQ=;
	b=TZQcwYgHEkQKzBdxCYgoF4NlP5tocqsMMzriVFP/C1WqBZa09mv2OB2oqDSLHTxPBMi56Z
	xx9RC2sOxOvZZSB4ZGllg+wsv4OXMdYS/+VlZKuPXwAaLh3FZ3j8s0rKXV9sp9qYypwgjd
	vjhVej7+5lui3ST4QgKreOQJE8m53gvuNdZR/+OogXkO4p1wJShVaMIqzRlCCXOYe+pENX
	A41rGs9i7z2HuLPiMK8mvMrTjZLIIZsWw1XDlCq3MJduJg23yNiKC8twgnpIePHoKQe12N
	yZpcBoh3XX/1DZmq/iyUy4UxgODCgMvbhy3dVFVwJVMmYRKpW+PLCnbcDGN+/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793696391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QD+CkWG5oyxTZO6V2pW1MZiGJv6VerTZJtv13Pu63rQ=;
	b=BkGYvZPsVd4OcDfywug6gYGoeGQK32t2wF3ew8Ol7bpFcJo40b4EnCyNA4YhhGdid6FuuP
	iS5opXFdm3oDP4CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] irqchip/riscv-imsic: Synchronize remote state with IRQ
 work
Message-ID: <20261103085949.HPHNwwhb@linutronix.de>
References: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>
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
In-Reply-To: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>

On 2026-11-03 08:04:33 [+0000], Troy Mitchell wrote:
> Without a real broadcast device, the tick code falls back to the hrtimer
> based broadcast, which keeps one CPU's local timer running. Once the SoC
> timer is registered it replaces the hrtimer broadcast, and every CPU may
> stop its local timer in idle.
> 
> On K3 the SoC timer interrupt goes through APLIC in MSI mode to IMSIC.
> When the CPU owning it goes offline, the interrupt is moved to a CPU
> that may already be idle with its local timer stopped. IMSIC leaves the
> enable on the new target to a timer on that CPU, and that timer can only
> fire through the broadcast interrupt, which is not enabled yet. The
> system stalls.

So the broadcast timer is moved on CPU which is idle and waking the CPU
is done by a timer, which does not work if the CPU is idle.
This makes sense.

Sebastian
