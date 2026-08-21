Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA030C147
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331472; cv=none; b=LM/FkhjtouoUvbfoMZHss5T92DrJB14QyT1/iTQ9s5LGs7ned601gdO/fgmjjf/2J43oG0Z/pwUlWn2Z9fvoGpqkLm2GzBDjrTE9EgBS7y/oNDxg+42yeMZVqRpNG3p2Fm8I3kw8/eJsBwxpBlDmsXj/V+yyba77ILc94k1KKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331472; c=relaxed/simple;
	bh=crUoEiSV1ZBJjt5qJhBiQEQ8WinJ/cVHhIbWF6yO3R8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWl3b1B1InjqZe98QvQdiCmjF2GJUPMhAGkqwSViIS/7MTq+h9caZwNEpPxxa2+N0Jy/zZrfRT5g4M+7/eNo9c1DAmIjr38oDL+ESraKy1kL2P7tH9PVxuudj4Zak9/HrPCP5mjRvDJtF6KNr7KyllWENix7z6hgpt6GuuZgClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Gcsxazk1; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Gcsxazk1"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026082116574616b4cb978a000207bd
        for <linux-rt-devel@lists.linux.dev>;
        Fri, 21 Aug 2026 18:57:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=crUoEiSV1ZBJjt5qJhBiQEQ8WinJ/cVHhIbWF6yO3R8=;
 b=Gcsxazk1W6MH62y7d/rg7ck92On/fePvDBdOfy8XjN89pu4iVq1gXMdfAioSsoMHd9fHHZ
 YWLDmhoKf4K1Rn+/SSR+0bwFtT/yw3oDnlcEnmHR7847QPJ8267tAqLSmpvmOmkPubvmWASu
 TcyuidFsB6XfBqfSjDrWYBHfRQ6vmusGp7gg+vHPzhkEw+5i/YLw3Tyc104SKvJByME+22M/
 OcMzuL/3B6uv3dhQuw6Nr3/4hwtGrrqnrElxx4W1dJb17Ks9+4WNScPLaaxf7jP8BYLHwncd
 sUdtx6bL0PXUD8i5DpWapE/Yu4AtDTRyOrig+mM2GWpefP1Rc58DlOxQ==;
Message-ID: <e0c53d4ef0765a37aa922af2e39fc3b128550239.camel@siemens.com>
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
Date: Fri, 21 Aug 2026 18:57:45 +0200
In-Reply-To: <babe3284-1813-4190-8478-4777a28af13e@lunn.ch>
References: 
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	 <f9daddae-a1c3-4823-a4b0-733775e1ad15@lunn.ch>
	 <babe3284-1813-4190-8478-4777a28af13e@lunn.ch>
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

On Thu, 2026-08-20 at 02:10 +0200, Andrew Lunn wrote:
> The problem with using stmmac as an example is that it is very old. It
> was added to Linux in 2009. I guess most of the SoCs at that time were
> single or dual core. CPU affinity was not something developers thought
> about for that class of SoC.

Agree, stmmac might not be the best example, but this is the "driver
under test" here and it shows a pattern that is implemented in ~35
network drivers as well.

Users of irq_set_affinity_hint() in 7.2, see [1], but there is lot more
that needs a revisit, like irq_set_affinity_and_hint().

>=20
> Over time the number of cores has gone up and stmmac has got faster
> link speeds. But is the architecture correct? Is the driver following
> best practices?

This are exactly the questions that I would like to discuss. Seems we're
getting closer.

>=20
> I would suggest you look at more modern MAC drivers and see how they
> do CPU affinity, etc. Is there anything which can be learned from them
> and implemented in stmmac?

I'm still not sure if there is "the pattern" how modern drivers (btw:
which drivers do you consider "modern"?) implement that.

What I can tell: Most calls to irq_set_affinity_hint() (and friends) are
a real problem on RT enabled systems as they simply overwrite any
userspace settings.

Florian

[1] https://elixir.bootlin.com/linux/v7.2/A/ident/irq_set_affinity_hint
