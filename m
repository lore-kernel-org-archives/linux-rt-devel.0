Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865E1D5AC0
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Mar 2025 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591246; cv=none; b=AksriFSJV0wtjpMSN0mkfU1ZK0mKz833OaZMxG1jr1fVILW/IU3l8xe93v9rMD1kIuAHRJZnI9Ae3BcD5RnV5twMq/tNS8ieNWCuo4Cdawa4br1XF7KZ+uS/eiTwceaHJ0JfbfWT/8EOyw477Wy99/N1XJ6QLL707soCm30w/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591246; c=relaxed/simple;
	bh=m2P6IaIe0y2Eb6HG85A2U8MEfp9BvGN6sUv+kgT6YLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXJzZNPMIoash7NjJ0NwaBEAEemaMI0RSwYjP5YDR0PmeYlyWSfr2o6qqRY5VFsyNLTdAAkwq2PijGLnBQEyFhIK3DZ36d+Rmkt1/m8Dg2rOqsdQYzmA83FzO4ieERDamh+IpaY+9EdzDO8QS4w5op2twODKGXzf2k9NpCwdAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUP8Qkah; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kZMKYmUj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUP8Qkah";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kZMKYmUj"
Date: Mon, 10 Mar 2025 08:20:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741591242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r31wY8KO473ETcrRf4OF7t85B18tUhGDJmvctDt5l/8=;
	b=EUP8QkahKNFPA8lzRNrK4LxT283NMhhYTiYVpMG+KU/6d7tP6S02p6aE1O5usc78Y5hKOc
	nDsnhmop25NBHcHqJBIp2KsO/qv4TSV6VibaC83WzEtHGlghSyQ/ym9QmObH5WCU0oFSmk
	USlP97sVw4yfEACWLKDfTm+azmvg4jQyn2BivT2nZ9aqTSRC2nr5BQS17LW58d/LoyPBuH
	ULeRC6FVX9WXt1HEoFhTcTiNTBWQUr3+2tPcQTH9FpONRKukOIImEoBbJvdU0fcLfAayci
	7vBMP737hBCnxAb1kF9vVJ4ee8qxsedgKTFdQzCUhuMGHXulp+OXeq9Rr7AOnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741591242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r31wY8KO473ETcrRf4OF7t85B18tUhGDJmvctDt5l/8=;
	b=kZMKYmUjTTRqtAtwv1KV20YYqlgQz8M45AG/4C/0gHE5nxRMIrD9iGzzvbANneFd8gU/CI
	cNDfrH5vzkDnK4Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-rt-devel@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: Possible circular locking warning in Cadence macb driver when
 enabling PREEMPT_RT
Message-ID: <20250310072040.Vn8rqifS@linutronix.de>
References: <5d31bebf-c377-4530-9f78-c9a440133383@roeck-us.net>
 <d118b65b-51ec-4ae8-8f99-30532c5bf5b2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d118b65b-51ec-4ae8-8f99-30532c5bf5b2@roeck-us.net>

On 2025-03-09 17:25:38 [-0700], Guenter Roeck wrote:
> On Mon, Feb 24, 2025 at 08:49:54PM -0800, Guenter Roeck wrote:
> > Hi all,
> > 
> > I found another circular locking dependency warning when enabling
> > PREEMPT_RT, this time in the Cadence macb driver. The warning is reported
> > for aarch64 (xlnx-versal-virt) and riscv64 (sifive_u), in both cases with
> > the default Ethernet interface supported by qemu.
> > 
> > Backtraces, both raw and decoded, are attached below. Please let me know
> > if there is anything I can help to fix the problem.
> > 
> 
> ping ... any interest ?

Fell out of my radar. Will try to look at this within this week.

> Guenter

Sebastian
