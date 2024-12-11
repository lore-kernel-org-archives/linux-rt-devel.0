Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC519CC1C
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930582; cv=none; b=IThofJiKB9DzqXh99M7CbnzH/QscnRbQYMcQebiXJHg89tGJIM/4+p4jht8sdTmfmXcrKikwX5N5ZB9fBi7oOJV/sTbe/5YusczNhaJm3dYoKddR1TUt0Gy812DMGXB07qE1iIBm3v+grJTPx65OcnZMihv54DMZBp/jIZMfoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930582; c=relaxed/simple;
	bh=Bj3HLfAaTEgLybrOE17CqojJW6/IovPwqNCEJh+a3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju4qIyIvnxQqGdYywRZXa0gbE7wshUUYHBo3mKDvqs8daTFj1yYTXjCPPJ1ZDFABUiBq+sEUPqvYG6p8oVGnzfI+lfQbf6ouOzYg5zuOSBlIzXxnGtC9Z//HNr0xXm69cu8n+GcEC3qw7UeVlyIn/X+OHtoAkVyMmL3RSkbpz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jPnbSjYA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2CAw6C3I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jPnbSjYA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2CAw6C3I"
Date: Wed, 11 Dec 2024 16:22:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733930578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj3HLfAaTEgLybrOE17CqojJW6/IovPwqNCEJh+a3x8=;
	b=jPnbSjYAsa/3sIBGYkpSL+Hfi0cotmj+NqQRjX4DYUGn8NA2Dv7MggsijYQ99IwrFB74T+
	K8xRV5yft1JGhjyBEH3ObAy0L4yqTDuCFEMoNcVa76sj1lRTOK/iFuiL7gASoGENOwzdTV
	hwOwiZLw1sP4f3iWyIx/91rA0DRySeA7gdLeYSCkM+nlBHlAXltDBaA73jP6DdV406N2Xk
	1+4CQwja+N77cYhux6O95ozJxvA1wARSq+kGfBF0LVPsk0RhoCZvCfTvHvMSL8Y8+fUUDw
	INuFoRhQeiJY4KK9u9xEWaq6Of5d+cljh99nfxZVkc0NPwJUsSNTnq7AqKARXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733930578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj3HLfAaTEgLybrOE17CqojJW6/IovPwqNCEJh+a3x8=;
	b=2CAw6C3I9ByddGJoOgM225O/zgyu2W/7Ypk8MHxeGq8x/Shuiv2hVVY7QAANWiEVmyaF1u
	VXD6kQ4mJJ1TNfDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Message-ID: <20241211152257.Igx3aT2Y@linutronix.de>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-3-arnd@kernel.org>
 <CACRpkdZaoD2vqbCi1AFUa6mF2_=c3Nu4R0CvxFAep0VMgtMtOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACRpkdZaoD2vqbCi1AFUa6mF2_=c3Nu4R0CvxFAep0VMgtMtOQ@mail.gmail.com>

On 2024-12-11 14:29:29 [+0100], Linus Walleij wrote:
> So fast GUP is supposed to be lockless, and should just not
> have this problem. So it can't be addressing gup_fast_pgd_range()
> right?
=E2=80=A6
> I'm more asking if HIGHPTE even acquires a spinlock anymore
> as it is supposed to be "fast"/lockless. If it does, it is clearly violat=
ing
> the "fast" promise of the fast GUP API and should not exist.

This is lockless on x86. The problem is ARM's
arch_kmap_local_high_get(). This is where the lock is from.

> Yours,
> Linus Walleij

Sebastian
