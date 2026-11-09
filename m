Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184672;
	b=o07leMRTHCjhxXtyoAhbvasnpfkUM6bf+w9XpLDn39i8YYeJ7GeiFFDan/0zBCmEHon0
	 tDCaJi/sbGOpTs2D8Kp4wMS7FbQXEV/XzIhBON95HADlDrdt/hTbaHcLiqp6P/pIx5NkU
	 HR8XRJ0slPMSCVzLFHgaOUDvbWSiGuOAH3WHERW2Pc0cYn0eDu/uI6M3WTB0xBaKmG9vN
	 10bEdtF08exmDTdsYs1vpWcS27/1scqu8laDHlx3UHnYsestc0yIPoDaajH9A3qyYrmys
	 i2OIhB5YNTGzvJh5lsvaVLlZhgzNztAObLolx2i7Iw99TLnpG5WklFIGv6gzRDGqsSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184672;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=pkifUF5nmIlWMW61S5hyAbdugpxrunbU+LdL82e6qFY=;
	b=cuj8iK6HWeiKfTW/Dd8QfFNXqAaBqpnCIJTaQZkDwwVxE+16C//iGSNnJ+SIe7ZGMyrj
	 U/doLcb+QdH1SW40Ai9RjEd4UQmdbFjzoBsq7Zs2o6z/P6CSL1FgS9UhU/RT9KgiIVpu1
	 GJRKNPNSurfQ4wL+swRd8g5T56z9ZFa6zeORVEf/341sg2mPbngiuMeYTF0flKPTZC3gr
	 gybaXb51OehPR1S956wlxq2NHWg7S2Qst7xYF1CUuN7DEVPfo1wp5GydeAN/FxAdJMza7
	 XGCFfJCW2fWTfLgqdYrKNRfnhBDpNUSBjPfb9bTYQBtpqqZ1cqlgSJVt2A4P9KW5Xaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FfDdYF/0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AD606A31C;
	Mon,  9 Nov 2026 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfDdYF/0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117DB1F0089F;
	Mon,  9 Nov 2026 00:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184672;
	bh=pkifUF5nmIlWMW61S5hyAbdugpxrunbU+LdL82e6qFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FfDdYF/0TBH4GR87LnK10ldiEPEHS/xeBrE4wzL5tx1pgzc19MLIFiSNbuIBySU0H
	 NhhonWR9hGQacK7d3MB82L4UrZUQiU41+GrW3IpXwPEFRnUb4VQoLN0gywZvDFtUDt
	 FFs1trFnLv+Gob6r+D1+ZWYqxnha7T6Qlwq9KmOTSq4NiMcHkWBHBfgFH9g+JDGvfn
	 VQtthQXroIfFT8DpMJMAI6bn/elcIhhpavr7Kjg40UrLta6s7So2TDWDqYkfkCrl4b
	 tQ5SKIMmwSO+UsIHw1So9cDsMUgAPdpTv381LyUi8equdvVs2Z2Ea0rOudiR8tICEn
	 XYCWzkWTeIkSg==
Date: Sun, 8 Nov 2026 19:37:45 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
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
Message-ID: <20261109003745.GA3429615@ax162>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
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
In-Reply-To: <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>

On Sun, Nov 08, 2026 at 06:59:26PM +0000, Julian Braha wrote:
> I think the name will cause confusion.
> 
> We already have some "kconfig checkers" in-tree, like
> scripts/kconfig-sym-check.pl
> 
> But actually, your tool is quite unrelated, because that one checks
> 'Kconfig' source files, while yours checks the user's '.config' file.
> 
> This has already caused some confusion in the past, for example in this
> thread [2], someone misunderstood which one 'kconfig-sym-check'
> actually checks.
> 
> In addition to .config vs Kconfig, the name is similar to
> 'kconfig-sym-check', but is not as descriptive about *what kind* of
> checks it performs.

Yeah, I had similar thoughts when this initially appeared in my inbox.
As you mentioned in your email, this is basically a policy checker (“we
need these configuration options enabled or disabled to meet our
requirements”), so maybe config-policy-checker or something like that
would be clearer?

-- 
Cheers,
Nathan
