Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03573B47F5
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Apr 2026 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284865; cv=none; b=ftb3Ds9xE3W9L8Zx8Dh0xxUSK6UH4sQNfKcK/uJVuo+0I1s2VoR9TX+wlJjiME4EmLWRw0fUnR2y2HBSqCv4jfDzmQYgxo8YSpj0/f0tXG3gYLUKZDXfzRu0bXrobIh+zfq4U5WtlyeXp1o0h8V5Gr42dJlpxWS5w2p+inyTmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284865; c=relaxed/simple;
	bh=NwvNzA77cTupsEIv6dal9H7A7nSRcWczX8S6oci8yxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gom8mxZ/0w4kbCC5xeutU4PlkG7U0wYFjn0YeaJ4eYxjbM3MoV0CWixo93it7P5yx3/oEkbZVTy0MPTGpg3xRrZtxrzeLmeMnD6ass8R5I0wcnCODcmJGFHvTYxgwnd7JJGffzG6jwC+OjVy2+S6SM84ESsqVO6WmjKKFMFh22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYyaOGDh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fo3QIksx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYyaOGDh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fo3QIksx"
Date: Mon, 27 Apr 2026 12:14:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777284862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwvNzA77cTupsEIv6dal9H7A7nSRcWczX8S6oci8yxk=;
	b=iYyaOGDhytUqJvSrIxSK+nkq/ZSyMs2/DpwRlCS0wldcYHIn7O2NrESm62Qe2jamiaGE/w
	H0KS+3L0Bdf0tTBWc53JFEHN2yZVjLLhn2GAzlZ5m8Y/BvZxG8NBs7AIYmrxtz2SHop5VU
	VHN/wEzsUGeD4gIzz5vcTfE6q94OWGTC3nnoK6QkStrKJ3tRmftEM+piRSMypzAmOU7/Jc
	+TMHy0x8TQdjGLz+RCKZ2l/TKBnWb7sSarQTLuYMxNwmAn9VfpWG/+gO57wYRFgxAWY6Xx
	oia3mHBV3TIHiJ3rfQqbrLEC9d3Cm925+zLjDp4yekxxNvhIYl+9c9GatjrVoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777284862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwvNzA77cTupsEIv6dal9H7A7nSRcWczX8S6oci8yxk=;
	b=fo3QIksxWzVdamRewmKjdxtyjLbotkLf90WEvnAeL5AaBHDvw2IBCUHnAy5M2zOQgtw4aL
	NuKtOe7cqy2nJNAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	"Varone, Dillon" <Dillon.Varone@amd.com>,
	"Hung, Alex" <Alex.Hung@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Message-ID: <20260427101421.7N9_OOk5@linutronix.de>
References: <20260409131411.10598-1-spasswolf@web.de>
 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
 <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>

On 2026-04-27 09:23:32 [+0000], Ostrowski, Rafal wrote:
> Hi Bert,

Hi Rafal,

> I am glad to hear that mentioned patch fixed your issue.
> Small clarification - amdgpu is not designed to support
> PREEMPT_RT flag, but it was still worth to fix as obvious regression.

What does this mean? It is not a flag but a preemption model. It is part
of the official kernel.

> Kind Regards,
> Rafal Ostrowski

Sebastian
