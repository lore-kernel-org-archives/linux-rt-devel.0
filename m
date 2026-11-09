Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243157;
	b=be+Ak3o092XEzY7m+8U7JPe5Q4LEiCJeOL7Aaq6iW8yUJREU+7EyDRwRftN1U4eznERt
	 BQLT44aEYlXo3f6Fu0Q62M9vfL7j0V20/kwBXlQb7dUYIVHdErskhQhrZenKdptzrcZ8O
	 SkeqLSUe43eUi0RwCVoG5vrySEzpTH4DFa7+U1qt6bAo40xS7QJ4sc/7sl6T1agWecG3+
	 5gEJInbemUP0JpKXqq+ewfdeY1Yel9YcBx6cSQzZngXarfzpSwGBIkW1l0uQiAjwuIcA3
	 OkTj5Mv5ung5+N7jzMI5h1GmhLnFJhGDcsXz0xJQXv3gdPQw5f+7MI49KGNQ40dKDkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243157;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=F4x7I/eJDYyTNVsMVYbfqhXkVQVdTo3yCjuGDH6ZAmo=;
	b=AaL8VjYhOXKTYFKU37QK1y2q9URQ+QPjQKIgiVI59cINtNZPTMV1jmeEfHqHQLhChEks
	 l15K2SsGzWsiywLej9MSuqtNtn3152VO5VTCLTCDHPSwg8dPgsZyZvJdCxcR0LFRtDi+Y
	 NBHKeVtcOae3kYKMTlbrFY51B4LATCZbFwmLviXYfJ2+o7G0dfZya8LMubya3n2yPUcvh
	 BHyPCfw/4iBftK8qu0SY7zSFkaRCLnQV9kQ9OZbuP7YOiAieoV5wPF1omvJTaghqh4qA6
	 kHe69YWL1nQRsy0FeLgSB+Rwu4i2xkByc7cN0PYSdtS0e7WSTX21mZcHrnE4/HnkEHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+cQ+oHs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE0606EE9C;
	Mon,  9 Nov 2026 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+cQ+oHs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE451F008A3;
	Mon,  9 Nov 2026 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243157;
	bh=F4x7I/eJDYyTNVsMVYbfqhXkVQVdTo3yCjuGDH6ZAmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n+cQ+oHs4cBbfMQFzvBzPg/8epEceBRPZMylsKnZiz3+Hwws89nXEICYALvf106wa
	 Td/07w2Zz6wxTWemagw6Hro2OlOdFYtgNIG47m3nxdipRli+udvLStWhBoXyT+dviZ
	 rS1eBYNcH4Re8jcrBgRC7T1U/sPqCwds69TvpevF0tKONV02vXJYggJ5/FGks0IOPP
	 GqpykssCnax7xbcvBzFVkkyYax4OrULS/hn+V1Ztdu43ueCJAK5IuRVxswwP+nxdi0
	 ELWNcxvxTd03fdV8O043AEfVmvWhoM/mhE8H0XdWfC+0Ois1m2yz+U04NXwUYXczuv
	 4cjoDbQsYICCw==
Date: Mon, 9 Nov 2026 11:52:30 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
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
Message-ID: <20261109165230.GC1608140@ax162>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
 <20261109003745.GA3429615@ax162>
 <avHxmCEdHgyRD7n0@lx-t490>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <avHxmCEdHgyRD7n0@lx-t490>

On Mon, Nov 09, 2026 at 05:15:20PM +0100, Ahmed S. Darwish wrote:
> On Sun, 08 Nov 2026, Nathan Chancellor wrote:
> >
> > On Sun, Nov 08, 2026 at 06:59:26PM +0000, Julian Braha wrote:
> > > I think the name will cause confusion.
> > >
> > > We already have some "kconfig checkers" in-tree, like
> > > scripts/kconfig-sym-check.pl
> > >
> > > But actually, your tool is quite unrelated, because that one checks
> > > 'Kconfig' source files, while yours checks the user's '.config' file.
> > >
> > > This has already caused some confusion in the past, for example in this
> > > thread [2], someone misunderstood which one 'kconfig-sym-check'
> > > actually checks.
> > >
> > > In addition to .config vs Kconfig, the name is similar to
> > > 'kconfig-sym-check', but is not as descriptive about *what kind* of
> > > checks it performs.
> >
> > Yeah, I had similar thoughts when this initially appeared in my inbox.
> > As you mentioned in your email, this is basically a policy checker (“we
> > need these configuration options enabled or disabled to meet our
> > requirements”), so maybe config-policy-checker or something like that
> > would be clearer?
> 
> I would've loved to keep "kconfig" in the name so that outside the kernel,
> it's still clear it's about a kernel .config. For example, a Debian package
> for this tool can be called "kconfig-checker", "kconfig-policy-checker",
> etc.

Sure, that makes sense. Like Julian mentioned, kconfig is certainly an
overloaded term but there is little we can do about that now :)

> What about kconfig-audit?  Something like:
> 
>    ./tools/kconfig-audit/audit.py -c .config -p PREEMPT_RT
> 
>    make POLICY=preempt_rt auditconfig
> 
> config-policy-checker does sound good, but it feels verbose.
> 
> Feedback appreciated.

Yeah, config-policy-checker is a little verbose and might not translate
into make rules well. kconfig-audit does not sound bad to me, especially
with the rename of RULES to POLICY; at the very least, it is on the
right track.

-- 
Cheers,
Nathan
