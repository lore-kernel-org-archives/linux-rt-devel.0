Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EA2D0C97;
	Tue, 25 Nov 2025 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055204; cv=none; b=m4e6N15QFSs3aiK0kLAJk/xD4Gn6w4YvQVF+mgmVKUsJZPUGfR9DexDNmrK/p4LI6jJK1dQeQStJXvrpFSzUXjXKM0Txy5dGwve8e0/RMb4qNhD8RgbC9psnue9tuw/ZDSL3J7NzgyZaRLS4E3svU00z1TkMaX5ZA+pGOMqU7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055204; c=relaxed/simple;
	bh=l1KGnfdEWgQxo8EMnEA85k3oluDT2w+FPDsczBPBX2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6adqQJXVDKnSppzZfhECau+VZtYeDV3fVTlCSSWRdhG00CGyqaiWyqWSCe5zoB0gweretb7Z4zuiTo8cdO1bXQ6cuyx5kBYuYxbDUpwYLp/3uw5goIXcK1K+z3EeIgmVVsMm6OSeTtnIL+14eRQWaqBdqy2k1sSqYBfLmrBNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YC/40B95; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSdtw+IE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YC/40B95";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSdtw+IE"
Date: Tue, 25 Nov 2025 08:19:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764055193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwwTrnevq8aBMZChM8n9BVFSmn/5A2CW3uQTKd2Zf8s=;
	b=YC/40B958OVz7kyyVkiAdOPN8BjF8uAJ3wSGuHryXxkFZ/YIbwvAGm7wrhmCcS2uPLGGh8
	DItusX7ufRCz1dIxtrI9LS4hULp5nzdvFUIwDpCOlKd2+ugRDhefyZc5K2Ua/pK+zl3VBp
	aoXMcVlro5yTibWFT46DfzwBe/0Uq9uIQfb/qNHz3QeR3wMMHTQVLIPWDyNTyB8J65k0fu
	k6BXMQ3V8+Ut91SPSM5O++r7aTznHCkvtDMp2yloeCRGfbNCWzRVNzfSsGevqkMX0FU+P3
	JswEbGhkFKTux+XUEPTAiApih7UXzM3XNPJiG4LE5PSex+U2DqJ8i3ltl1aBew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764055193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwwTrnevq8aBMZChM8n9BVFSmn/5A2CW3uQTKd2Zf8s=;
	b=cSdtw+IEfkBAvysHW4p6Zt0uRCpvrh93EUK7uwX3AJ1s6XxNo9zn9H4bn6ZMce7Zirnmin
	gG914HjDPXZF5xCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, gus@collabora.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [REGRESSION] stable-rt/v6.1-rt-next: (build)
 ./include/net/ip.h:456:14: error: default initialization of an obj...
Message-ID: <20251125071952.lq2vP2n8@linutronix.de>
References: <176403954885.358.6925837698022425297@f771fd7c9232>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <176403954885.358.6925837698022425297@f771fd7c9232>

On 2025-11-25 02:59:09 [-0000], KernelCI bot wrote:
> Hello,
Hi,

> New build issue found on stable-rt/v6.1-rt-next:

Thank you.

> ---
>  ./include/net/ip.h:456:14: error: default initialization of an object of=
 type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the obj=
ect uninitialized [-Werror,-Wdefault-const-init-var-unsafe] in security/sel=
inux/avc.o (security/selinux/avc.c) [logspec:kbuild,kbuild.compiler.error]
> ---
>=20
> - dashboard: https://d.kernelci.org/i/maestro:dabc8a89dbfbb7a418c712c2c6c=
82e29bd2c9573
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable=
-rt.git
> - commit HEAD:  14fd3f12318030025dddcaf840092144c3a99e89
> - tags: v6.1.46-rt14-rc1

This one has been "fixed" by commit d0afcfeb9e381 ("kbuild: Disable
-Wdefault-const-init-unsafe"). It is also part of v6.1.141-rt52 and
later.
=E2=80=A6
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev

For RT, or kernels in general, it should be enough to test the last
kernel/ tag from each release branch. The older ones, such at as this
one, may contain bugs which will not be fixed in "this" release but a
subsequent release may contains a fix if possible.

Sebastian
