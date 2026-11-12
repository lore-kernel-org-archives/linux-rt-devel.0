Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505848;
	b=vxtIG6cwyLZMi1CWBr1cwTbSu7MpppT9RSACzohFmM00FI/VXhUlCpC8YJHMFiGaTBYn
	 0nnPq6GUaKFhHEYTgfaoViNLIr6wzFd22UA9bNBngdm3M98NhY3S4B2qN+kRGzjgJ77Zr
	 eMg9WOQYlfO44tyPE7ot5dPqJuwc4I4BpvCAwZnHCd6lbt4JaO1zW7WgHMsIqwD92rrdd
	 iGwsu1D/kFbkKQ3h4KGviwRTuNeeIz9Iy0ycZhUo7s1rnuW1zevVewdoSZ0X3EolekWew
	 J/We5HNyJZjQEkwtSPQLG0GRI13IgNLmHY9t9m8O2Chxkejiu/F6rvKhBzpujD7+FKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=beeOAyy62Z/y67qN0vbvBoBT+IGAHk/F1Nhql7nw9xE=;
	b=LJAJxys5uIMuJ6Z/vF49gLEv/mTPYnm45y26qZn/YMSK5qCPGh/XUJO7LeQrzJ7segEL
	 JHUgmj9ukv44au9PlVNVUBEGD2xQ3L/iboUjEW/4VQ8oG4iViwD9HSoPTOHkxsCA3nOyO
	 haLacjuPRx+63NzP7/uhDupx35tZ/PLj6fV1D3roxDUApT7HlzfVvElwVebTuOZFoJSye
	 wKOl0xQMZsgaxq+8jrKAmfJMZP7k60/JGYvopmlOiSXuutHWzNw6sa9E2Lu3wvissu3QS
	 29KMsrlovwHaFfkOt/ix/PqGSsSPdHm2PFt6Sx+4Ku1G4IfQV0ZD31XYTLXITfjxdRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrJgw4TI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE010606A31C;
	Thu, 12 Nov 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrJgw4TI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752DF1F000C5;
	Thu, 12 Nov 2026 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505848;
	bh=beeOAyy62Z/y67qN0vbvBoBT+IGAHk/F1Nhql7nw9xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mrJgw4TIIS4h3OcHNHYWca91+IBi230SGeV/NAGezKNdlBnUdXOPSl7SnRLzB+VHf
	 VUhyrNgSa1JpdELK7PaJgzrKV9FuZMzG6Ccg6dC0ERjbq6NswNGms0FUJ5FQVz9wT6
	 8vy+9ttiX3/2BtYBe/q53a9NsH9OhbIw/Qtw75w0in+EVZmzAbSbwt+Duj1yIqWNYH
	 fhEFRaf3FQE0HIrbtUhRXA+cSZwZg7ciq7s/IKMeLvAv3U/uoTgl9PrFWP1rDd69Kf
	 jHJvzBJSiAykZ3Vj4zFJCQqQIJrrPekn9zi2sv4C3zeq6Xp4JGfrZGSNEcV/zmdI+l
	 +o24tEp4jj/9g==
Date: Thu, 12 Nov 2026 10:50:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Nicolas Schier <nsc@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Julian Braha <julianbraha@gmail.com>,
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
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <20261112175042.GD4107043@ax162>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <avQNdicGzL3De556@derry.ads.avm.de>
 <avWy2r1BcDatzwo1@lx-t490>
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
In-Reply-To: <avWy2r1BcDatzwo1@lx-t490>

On Thu, Nov 12, 2026 at 01:36:42PM +0100, Ahmed S. Darwish wrote:
> On Wed, 11 Nov 2026, Nicolas Schier wrote:
> > Are you planning to maintain it after inclusion?
> 
> Yes, I'll be happy to maintain it.
> 
> Would it be OK if one or two people from the Kconfig side also step-up as
> reviewrs?  Julian? Nicolas? Nathan?

Sure, I have no objections to being a reviewer for this tool. What
tree(s) do you envision this initially landing in and taking subsequent
updates through?

-- 
Cheers,
Nathan
