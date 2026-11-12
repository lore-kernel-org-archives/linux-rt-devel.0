Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519087;
	b=Ub2eDI87PCkn0/FSktGNXfcoA0gi8w3cvclo/4Mxu8lBFqmgUTt6spjrcNcui4mRMPoe
	 Q6KeOJ3clMDLsuec8/RsQ53vTS8YV8y4pKRJ4vqwxlsFigP7ZP2wUHfsGXgCaM3SP495h
	 8BqLdH8x69HGeUuu3fPXYp6MC3aEaVJUR+Aa864MGlQwoxTurCKaFA7PMeI4UZZfyF8f2
	 st1kx1a7LMa15b2+cfrMEePxugRpOJ+2+BZ+H2jDItGatDTIBkeB4ywW9Smpe6HcMN8T4
	 DpgHLtm7NlAQpYan5DeogLECQ9+yfX4hiB4f139eH3lvESIs/41SRDalMcgRmM1EFOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519087;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=X2jGY2B55gs19JO82DR2MUd+5P11FRdNArkeVNyYS8c=;
	b=XUG/K+/O3ywISrvMkpHEX6s/FbtScgPOlVdml+JnmtMG9HiPDGvcxGEan3XMSBZBqbZz
	 vpOH6n/oz++buGBTDfRIrmVT70RQyuBzEWEXT2Ii7s0H6d3XOlF9URCl4kNhtInu+TxF5
	 X9/Ev9jE40zpKrzYz30TLRXOhzUr6KuNjGZkOPz0IOuD8Fzdidnlgda+OFgj/RFXTONk6
	 /AveKKEv1GavjMgGyTEAB8Nd35iKVR+01ztAGgeIJAl9nnmve1cCrsdYuNDswE/N+/Jn5
	 N00N2a7/9YjlBrPgwtGRKv54vilfLDKDQEcTF6FlONu8AWTptWkgk1riAFTER433pxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="2/YZSWWC";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FBXaMFav;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC844606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 21:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC844606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2/YZSWWC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FBXaMFav
Date: Thu, 12 Nov 2026 22:31:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794519084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2jGY2B55gs19JO82DR2MUd+5P11FRdNArkeVNyYS8c=;
	b=2/YZSWWCqCt8qr14vyLr3SZV8YOVeSocinAbKb3MikFgyOuiWqh/RGtzFz4zyHLaZd/QkR
	ZO/i6rkudZyMY3jnBRsIsZs7K1TtJ2CD67PjyC9SyYwlrrlrldoxH6iIoT2Voh3NH0FmH0
	ZrsZULTn//L6Wh7X0Afi4W9tJqXmQLlxrl7BvFZYYVGQxrwamEYHAsVPwwREbie9ENUWLi
	M7M0X+6NmonRwv27geXvB5++i3WXkixEn/imRQSGiNXf9csKrAjJoyCdSBaSf6OP+n5KFT
	/BVitZJfRyvh+mEqPxVyS+BS++n0GTUXg9T/UT4VpX7BRHf3mp0jqqewkvfvIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794519084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2jGY2B55gs19JO82DR2MUd+5P11FRdNArkeVNyYS8c=;
	b=FBXaMFavNoJpkNUsEcQRm8+tXyYatEmjsRZvVY7dPp1fm5G00WJiw1fETJ1K8heOwEbAu6
	TM0l7PuvUySgD4Bw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Nicolas Schier <nsc@kernel.org>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/10] kconfig: Introduce OVERLAY= for make checkconfig
Message-ID: <avYwKuCrHOHV_gOw@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-11-darwi@linutronix.de>
 <avQNgXSWhODyc5Fc@derry.ads.avm.de>
 <avWmzbh3rp7TawCn@lx-t490>
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
In-Reply-To: <avWmzbh3rp7TawCn@lx-t490>

Hi Nicolas,

On Thu, 12 Nov 2026, Ahmed S. Darwish wrote:
>
> On Wed, 11 Nov 2026, Nicolas Schier wrote:
> >
> > Please add the optional overlay arguments right here:
> >
> > 	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(addprefix -o , "$(OVERLAY)")
> >
>
> Sure, will do.
>

I've just tried the suggested addprefix function:

    $ make V=1 RULES=preempt_rt checkconfig
    ...
    python3 -B ./tools/kconfig-check/check.py check -c ".config" -p "preempt_rt" -o ""

Notice the breakage due to -o "".

Unquoting OVERLAY will make it work:

    $(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(addprefix -o , $(OVERLAY))

But it breaks the consistent pattern of quoting all passed variables.

So, can we keep it as it was originally done?

Namely:

    checkconfig_overlay = $(if $(OVERLAY),-o "$(OVERLAY)")
    ...

    checkconfig:
	...
	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(checkconfig_overlay)

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
