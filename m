Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24517A586
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330869; cv=none; b=Mi00v/C+3Kl9Gs4Lx3vax2jZmyFp5Re0DXboMmzS885HY0ddFhWGkJ7MTDsphCpSZa+YAhitLTLFq0sspDVBtOHVQ55upZzC8ydhR9Sso1dU3QPoXqmE6/zIFXHpyUy2t83PpEBz1811y22opipdj9Lvd/hm05mSE27GsmgAAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330869; c=relaxed/simple;
	bh=6hWEk52ybKytfOaNhLZYJpexQsQeY7dx+xyw91Pdc1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pa9qPnF7hwFnrudKWqi9q4/fl9WR+hoBvNj3RSjOMP8WnfYDfVQhuuEl3QDSNLWZ/AdsuTmrDrMMdMcAiou5ikEZsTaZgKeDTwKFKJx3FPGyOev7VjhEzP72ETu8iuUxBT8CCT6Fkl42s1fZgHyPDGfw5ah7ECUWdiUXpJwxWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TBwnOHPP; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TBwnOHPP"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260821164737ba6c5b82f600020772
        for <linux-rt-devel@lists.linux.dev>;
        Fri, 21 Aug 2026 18:47:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yAUIv3QVPUxeZj+2jjQt2DSdbC2rNzRDTLXd8pgK7IU=;
 b=TBwnOHPPmjRt/JJJmjAiFj3ThMLkDziWdpLctnwdO+1UQAOFwoxw3/tkqalYvIdHHJQ8AT
 aVz42iTgxiI3vccu4INGZGXK2lFvmYyB0RLzrmaiPlm6h6uHrjBmi6NPuO50z/w4gYMBYa3n
 q4N8k1dHw7zStWfaztBAoDzvbYBLUcSGHDv50xi0rhJrkAadwWhGoX72zFrh8c6U6VKc3kur
 rKCiJupR9LV9FBoqDeJk0+E9s2oHpHNGrRy7uMg+N5VIIo81OrGibQOke/9d3R6X2l0jgnu1
 dszOSZsmJJFhQ3VrrIRrtpcf8/kNstKWOHRbSrwuR0vIAtlc8Vjpp8XQ==;
Message-ID: <f452f083e6597a145ae24f80f1db7f2315bab6c2.camel@siemens.com>
Subject: Re: [PATCH RFC 0/3] genirq: Allow drivers to respect userspace IRQ
 affinities
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes	 <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>,  Sebastian Andrzej Siewior	
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt	 <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, Jan
 Kiszka	 <jan.kiszka@siemens.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Date: Fri, 21 Aug 2026 18:47:36 +0200
In-Reply-To: <f9daddae-a1c3-4823-a4b0-733775e1ad15@lunn.ch>
References: 
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	 <f9daddae-a1c3-4823-a4b0-733775e1ad15@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Andrew,

On Thu, 2026-08-20 at 01:54 +0200, Andrew Lunn wrote:
> > That raises the question why request_irq() is called on "link up" time,
> > while the low level vector allocation takes place during device probing=
.
>=20
> If the interface is admin down, the hardware should not be generating
> any interrupts. So there is no need to request them.
>=20
> > At least that seems to be the common pattern. Can someone tell me why
> > this is done this way? Shouldn't we call request_irq() at the same time=
?
>=20
> If you want to change anything, move the low level vector allocation
> into open(). But you need to be careful of EPROBE_DEFER. If the
> interrupt controller has not loaded yet, i _guess_ the low level
> vector allocation will return EPROBE_DEFER, and the MAC driver will
> try to probe again later. If you get EPROBE_DEFER in open(), there is
> nothing you can do about it.
>=20
> 	Andrew

Moving (=3Ddelaying) the vector allocation into open() would not help
here. The /proc/irq/<n> interface is populated on request_irq(),
normally done inside open() as well. Up to this point userspace is not
able to set any affinities.

This is one of the shortcomings mentioned in the cover letter. Once
/proc/irq/<n> appears, it might already be too late for a proper
affinity setting, the IRQ might have fired already. In addition there is
no notification mechanism that informs userspace about newly requested
IRQs.

It's more of the opposite that might help: Moving request_irq() into the
probe() phase. I'm wondering why the pattern is
    vector alloc =3D> probe()
    request irq =3D> open()

Seems that we would not "waste" too much resources when we move
request_irq() calls into probe() as well. But as always: I might miss
something.

Florian
