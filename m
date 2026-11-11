Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379329;
	b=epypi5hPWmpoRdWW86zro8faU+tFQ4JTPE0bpmJ3t6zcXuCAHds0BVYNwS2PSG/y5DAR
	 d0xZmmOqCCwRVMpC+HlDm01KG2L5zRK80zWIPBb5AmZ/5dFLpyXHcpGVIWuS9cBnQUS/G
	 Y2thSakx2/u8baWwpxhSvtUbz+rk/G8UVifCDHrqaC7gVn+OR0mgEklnALoWfnDmale1w
	 z7qoKgO+xEXzYopcDbT20eA46JsyLiTLpPJEpUTIDXmTBT8bI3H9gbYrUBapzxvqwHJrz
	 s3IGwe1w6HFwkU0Ok3bLcLL1DA4soS2RQcuAhB3KHB/KtaVhqmC9EYX9iBQKRn1fvCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379329;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JMWXL0IXWU5URfYmUKPMvMiRfFnA0NQMxrEdYjaJgT0=;
	b=4jBTT2nOU2BzKNWrM0Q/G03UHXefX/S6O0qG29ymHAXI3yWTK20zUVJn0yjDPgzxN8Cm
	 Fuy2/Gr6D4LbSUEN8qFuN32wODQQSgLFEC8jnpmi7XSfq3qqU+BglwClcBg5GdSri3QqA
	 dnVxgBdFjDyKlftNmJHhw7qIBHvvqXATUQbCU7q1iP6nTikmJFR7H33hNn5k7Hf8iuwoJ
	 TTcc8ZYx9ouxxR+6mqk1VvWHVePU4oAlGhHxj4neBfeYVzpwZCP9G976ZnAlH3k5ISLh0
	 udMitzPSRXa/d0nBAmd0FWKj4SVv4g28bsKUekFn5ZTAVHYHOF3zzWojacZ7casmMww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lA/icQm0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74559606A31C;
	Wed, 11 Nov 2026 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lA/icQm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4B1F00A06;
	Wed, 11 Nov 2026 06:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379329;
	bh=JMWXL0IXWU5URfYmUKPMvMiRfFnA0NQMxrEdYjaJgT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lA/icQm03x4oFDQdKhJMDq5IkCpHPztAq1mDadT/f25IrRvYePGBJ6rXwORQ9u8WJ
	 FP2za20qLk3AndaTGeBWDu+KgdQVNeUPaaF9wdPR2lJA/abLbOqdz0zVb6UsTgkMsj
	 6VwrhKRYgCGX0XLSGP3IAfBAjiMSfGJzsuKAJsJUx54nCXKZxJH4asGSA5ijhTbWJ6
	 iOHuVybSf3XXBSTlW6VkBRNnadLfOYeCwZIftMLKCBzoWBEcq8RzzD90MZIsXMW07p
	 wf2yFpbl0j74NxApHQiiAyBcijZVSigYgleMnMP6mUW9e7KgYCMCn+npXBIZQaywZV
	 XhOS4oA6YDm0w==
Date: Wed, 11 Nov 2026 07:38:52 +0100
From: Nicolas Schier <nsc@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
Message-ID: <avQNfFbeoMImmtre@derry.ads.avm.de>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
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
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
 <3dd2bb0d-8486-4630-b496-e92e4ac37c29@gmail.com>
 <20261109003909.GB3429615@ax162>
 <avHIOS9NHwCCMITd@lx-t490>
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
In-Reply-To: <avHIOS9NHwCCMITd@lx-t490>

On Mon, Nov 09, 2026 at 02:18:49PM +0100, Ahmed S. Darwish wrote:
> On Sun, 08 Nov 2026, Nathan Chancellor wrote:
> >
> > On Sun, Nov 08, 2026 at 06:59:45PM +0000, Julian Braha wrote:
> > >
> > > I think this tool may belong in scripts/ due to the kbuild integration,
> > > as was mentioned in the past on another tool review:
> > >
> > > https://lore.kernel.org/linux-kbuild/20260428183101.GA3304253@ax162/
> >
> > Yeah, while I would prefer for the script to live in scripts/ due to
> > being called from Kbuild, I am not sure if the rules/schemas belong
> > there?
> >
> > It might be better to keep everything in tools/ for that reason,
> > especially if this may be called externally, but I am open to other
> > thoughts.
> >
> 
> I would prefer to keep it under tools/ as well.  Because of the PREEMPT_RT
> policy, and the possible extra policies from ELISA, etc.
> 
> This is why one of the development rules at the top of the Python script,
> at patch 03/10, is:
> 
>   The tool must not depend on being run inside the kernel source tree.
>   This simplifies invocation, testing and possible future packaging.

Then, please move the argument checking from Makefile to the script
itself.  Handling wrong arguments is good native feature for the script.

As far as I have seen when skimming through the kconfig policy checker
code, it does not use any Kbuild variables.  So, if it is being placed
below tools/ and does not use Kbuild at all, and is expected to be run
w/o Linux tree context at all: why do we need an additional top-level
Makefile target for it at all (alongside of
'make tools/kconfig-policy-checker')?

-- 
Nicolas
