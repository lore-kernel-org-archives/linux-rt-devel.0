Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228006;
	b=qUOZ3KaCqbBfpJTRzh2D0hpkD9hCA5u7d/pV6pmEbjORV6+JecaF4jg6ocBIgjMXw5kM
	 o1PdcR38AsWO+u4UmNz/x2sVOTr//pYd3rnZOcNnHnCQkWUFL5BnL55IzT0o53XOTgzRs
	 mpkJz5+o9uL6q2bcSY57D1jXVcGaURqQDJTWCH+fOZfFRWfqcfVGuPu52hhtnu+lYKx+r
	 hsyW7OkwoTqerVOZK2q6Pw1mU67XBuC57RKkTF2IISZviIlPtKjmLBGVFBQN+B+zw4xy5
	 uEwq4+DNfocCU9LFPmAFxJ7RfgyR8W0Q8yrj537fVXKWiWekynHtzbt3TyZVq2g2j4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228006;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=WWb056gPipccz0Z+Rf2etpC3VqitL7tkSZ//q9NzwZQ=;
	b=NgZbNiwK3MUKMAKx0gGNxSFjMuZQFXUFr03ABQOmCgiMRyPv3giRpTygL2YaSGcNRhRC
	 iz9cwFflYKc5j25pMiEKXV/q0xyNNvhd9cYam7SY1JOysnysWMEThC/4CHnyXItxVB2K1
	 KqvX5/wyiVwQXMEN5K3tIK88jLE7u0HumZ0fU2jbiDJ2wtOr3YpQQF47WGLGEBXQuYSpw
	 LI6zHmeN2BFDMSBXEnkKO52m5W7OA3RwxABAtsR9a+zhOoq1jWM6kyqG56j7AOyrkcI92
	 UujnMqPZVpQISo3kpLdsgUrTt6wu4MZG5TOHNxGjaP2WUsKkQZg4civf0324NOgL4Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NgpkRXhN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9piDjCwH;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE4606A31C
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 12:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CE4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NgpkRXhN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9piDjCwH
Date: Mon, 9 Nov 2026 13:40:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794228003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWb056gPipccz0Z+Rf2etpC3VqitL7tkSZ//q9NzwZQ=;
	b=NgpkRXhNAxzUdTG5+1ErHI4Bdi3xz5RF4IbE05z4lhqW3Dim5Co5HVJWuOmL4qpjo+eQ9k
	UDKTieCgat9zt9axBKLg3dPvNHHYVDQ0uajk3f+rt5lypdGnp3WMbxxPy9dPvuh01B7CTO
	n6NqxcShKB73869PlhdU91rB0oKSDeLBaJ5xVnZm5X/ekrpMEsQgKrULUQ4cdMCupYtwhX
	D8JR7mArn4pBSmI+hXrVP3eE8BSWZlbf4Uu8+KARHwce4MceN/BHgJ6VwEFUEgc9yX5+9U
	YIw3Pq9M7dQmp5bWDatkHW0kvPMHT8H6wGP+6k2cjpSeRCH60CQNDHEzRfz8Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794228003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWb056gPipccz0Z+Rf2etpC3VqitL7tkSZ//q9NzwZQ=;
	b=9piDjCwHPumPCCOarJvE9FW/bdj5Kujx5ekmk8xq7Wv01NAeZeA2TLCtygQfXf1LNGDyrD
	6XWvkZp3iiNuC4CA==
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] kconfig-checker: Add schema for rule files
Message-ID: <avG_IXPcRY7njMgP@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-2-darwi@linutronix.de>
 <e0ffecfe-8c4f-457e-ae8d-32a9601e69e5@gmail.com>
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
In-Reply-To: <e0ffecfe-8c4f-457e-ae8d-32a9601e69e5@gmail.com>

Hi Julian,

Thanks for all the feedback!

On Sun, 08 Nov 2026, Julian Braha wrote:
>
> On 11/6/26 09:19, Ahmed S. Darwish wrote:
> >
> > --- /dev/null
> > +++ b/tools/kconfig-checker/schema.yml
...
> > +
> > +        #
> > +        # Expected value for the matching kernel configuration option.
> > +        #
> > +        # Values:
> > +        #
> > +        #   y        option is expected to be enabled (built-in or module).
>
> Kconfig's tristates use 3-state logic. It seems like you're
> approximating 'm' as 'y'?
>

You're correct.

'y' is deceiving, even with the comment beside it saying that it implies
either a built-in or a module.

I guess it would be better to have the expected values like:

   expected:
      type: string
      enum: [enabled, disabled, allowed]

As a bonus, 'enabled' and 'disabled' rhymes well with 'allowed'.

So the policies can be:

  - name: CONFIG_PREEMPT_RT
    expected: enabled
    ...

  - name: CONFIG_NO_HZ_FULL
    expected: disabled
    ...

  - name: CONFIG_DEBUG_FS
    expected: allowed
    ...

I think that's much cleaner.

> These are meaningfully different values :/

I wrote some policies beside the PREEMPT_RT one, and the main requirement
was always that a certain kernel feature is either enabled or disabled.

In the future, I can add;

    expected:
      type: string
      enum: [enabled, disabled, allowed, builtin-only, module]

But so far, there was no need for that.

> > +        #   n        option is expected to be disabled or unset.
> > +        #   allowed  option is permitted and must not be reported as a violation.
> > +        #            This is used to exempt a specific symbol from a broader
> > +        #            `name_pattern` rule  with `expected: n`.
> > +        #
> > +        expected:
> > +          type: string
> > +          enum: [y, n, allowed]
>
> What if a user wants to specify that the value can be 'n' or 'y', but
> not 'm'?

Is this a real-world use case?

I did not encounter a need for making the expected values that complex
before.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
