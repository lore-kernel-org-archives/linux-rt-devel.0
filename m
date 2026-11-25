Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626112;
	b=ZHf2AFzvy85f5nlu4ZA2Ueb/a8BxtONUn8arEkPMt9m4QgKXA+UcJBoadFSgB2p8qfJ/
	 ktJlfozbqecLcCmG5PnRysvFpxwbytxd2WFXwnMdy7Mj5Fo69a0Ad30VEieab9Otsg7ux
	 M+WedaCFScXUmXlOnKs2lGmD+SbN1WR1v3cb1aTHyDyTUNyg49A3EDD+Y9jOiMQDVRfGE
	 ZU6k9BvZK6wJdT5cGQztQRXrmTAPNXq2cnGXJVsnmkZ7uNYTDM/PXVMnq0BNgjtYASqmQ
	 LHUUectWzkP2UT/C4xyUTSD/Sm8FTc72CPdmumo/Ry8Z/KTuYhuDOb8ItAgTyhf/K7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=+nUYa6c+5WDvUv90mQky2tB8VpUV0DepU9SZC2YSRME=;
	b=Gzo4/OnFuj2r9n1uaF/35JA0e00WJRdeE9WOLBQbJLQsAOv5ef3SgfxAyNJw04JuoVWX
	 JRpqztz/NCIYvsonuD7oOpxS25gtUIB6p24h3eJm7z0G8PQQPs2sCJp+Xom/PhrxLuXYI
	 W+6bMAvcAIl+miI/V5c9tjiU/8ACEy7+GdP8OLPN9K975Das69nloNNkEJdyGmbdcMgYU
	 D2fU6YhZ8lCfCb04BuwfzKwunRQ4+hEzp3KhAiFesRMeMAO6inCDAzMWKm/z7w07sGzHM
	 6432tzPizIRxqgDyWbZuFLESns2hbimXh6sUOph8I6CAgpQl2kzOBuyMZ1/e9K+FGuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ox/JaE3E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F4606A31E;
	Wed, 25 Nov 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ox/JaE3E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0159D1F000C6;
	Wed, 25 Nov 2026 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626111;
	bh=+nUYa6c+5WDvUv90mQky2tB8VpUV0DepU9SZC2YSRME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ox/JaE3E8aRrpR4xKKhExs9j+oNdc++Ij5WHK9IxOIQxB8NrX81eyvNK1cs8159Z+
	 s0IHlC92PcjVEu6vNmseYg8unAAmfNNVBSjhpBEtry5ozIqKiNoC67PdQyDdLUQhEz
	 F4Zf+G5283T3YfLsc/+0GhKeeHU54k1iTyzdq2B+wpXRvqDRCn1ZTvcJsAJtEyz5ES
	 b4DZxxMQ3zcnCPYhtbjic+ixudhTyiD0tMkRUATbUlz6ImcNpShdnL7vUEYy86JNJf
	 FyJCReCwDnvMKausiLA+BVM0ut7BdNDLJdSdV1vp1x8vYQneCbAMrFcauS+ei3Mdd+
	 NqKQce0yVZSpg==
Date: Wed, 25 Nov 2026 18:01:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zixin Wang <w1355457260@gmail.com>, linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, darwi@linutronix.de,
	john.ogness@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, corbet@lwn.net, wagi@monom.org,
	atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: real-time: Add runtime tuning guide
Message-ID: <awcUfLXNfhoYvHJa@localhost.localdomain>
References: <20261125074658.33117-1-w1355457260@gmail.com>
 <awbgq0xQyJATel0_@localhost.localdomain>
 <20261125145253.iWfxNCmy@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125145253.iWfxNCmy@linutronix.de>

Le Wed, Nov 25, 2026 at 03:52:53PM +0100, Sebastian Andrzej Siewior a écrit :
> On 2026-11-25 14:20:43 [+0100], Frederic Weisbecker wrote:
> > Le Wed, Nov 25, 2026 at 07:46:58AM +0000, Zixin Wang a écrit :
> > > +CPU isolation
> > > +=============
> > 
> > Isn't it kind of duplicating Documentation/admin-guide/cpu-isolation.rst ?
> 
> That is why you are here. I would suggest a minimum here to make sense
> and point the details to that one.

Right.

> The wording is the old "RCU documentation" and it is a bit strong. The
> "power consumption" comes from the part that the RCU threads are woken
> up to check for work. The better improved "real-time response" response
> comes the fact things like call_rcu() do less work (in their IRQ-off
> section, including waking a task) so the critical section is smaller.
> I wouldn't expect a huge difference except on small HW where every
> opcode becomes visible.

Ah yes indeed, from the call_rcu() perspective it's indeed less work,
especially if the queue is empty, the first callback doesn't need
to do the wake-up. That could be worth mentioning.

Thanks.

> 
> > Thanks.
> 
> Sebastian

-- 
Frederic Weisbecker
SUSE Labs
