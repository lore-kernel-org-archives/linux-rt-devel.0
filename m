Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154D332EB1
	for <linux-rt-devel@lists.linux.dev>; Wed,  6 May 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096484; cv=none; b=ZBD2YXaz4PWB1hfqzSRRBrzr36T4o9USZ/SyXgg24ieh34gGPCZYtW9GK21aBRPWv66uGviTWNJj49h/je89bb2EZzI6BzDbqyoWoZcjEaoEd4S6E2Fj7Siz35LR4qWOQmzHHV2BUYzDPYICi1srZ4gfE1Et4FK4qJNh6JG8LEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096484; c=relaxed/simple;
	bh=coJtQ+FgTz2kkB+lzkzj+iOJQlTgxblG3WIYPqozQVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLtLvZSkFaKXaCmfhtdUm7wmlIhz8Qt0Uo0xCU2kHCx+5sQ97lC8dvnXOuxaqPhwVFZ/tOOAe/SxvbV3t1E6hhkL64RZvPM7+sfTsvh/Zd+MbneIrl1doVbHUCV/kTsh7dpz4SPawUI3IeESMmmMOSLLInNSMcPQMcZ9i+gbrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbZoa8vJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AxqgQ+t4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbZoa8vJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AxqgQ+t4"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778096481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijqy2/d6J8ZQPVUOuj/buCO3IPceYWbMDmJ2lSlKffY=;
	b=wbZoa8vJnVAQzN2n9Gg5pRURCxDLtKvidUT4grPOrcMuLMSOKLzaq5tOQU0NcII8yqWBKb
	TFwq2hnf0Gf2h+pT2GIv8md19OB0XZBiHur6hvjoA25F9+6buV1w7hTL7DheTlaWsjikoU
	Cz8bPA+I0r0zYl2WkV3z9BAZV6GDhJgVuP3t6dbAxUfESeBXzXT2obJQG8wY1lSLt2MeJz
	TlWktHoifpgmlvKDdFOFnvNRwaL9bJhIre5Hv6jyTKFQGv2DGITHrCbvIiwBROUSxd/MGo
	3Hm/wFCjXIPY/JPKJMU7kdQIW7z4P8c9ODCPTEGhMa3DDyFfctYyfeqgLtrRrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778096481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijqy2/d6J8ZQPVUOuj/buCO3IPceYWbMDmJ2lSlKffY=;
	b=AxqgQ+t48lMxky7rv8Yzqy0Y9V1z+YhT8BmuILKMsKY3RHcl6vAFmkfG+H6hXSzUS/JgKV
	F4Sd8RByCEUoItBg==
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>, Bert Karwatzki
 <spasswolf@web.de>
Cc: "Varone, Dillon" <Dillon.Varone@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
In-Reply-To: <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
 <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
Date: Wed, 06 May 2026 21:41:20 +0200
Message-ID: <87ik90wckf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Rafal!

On Mon, Apr 27 2026 at 09:23, Rafal Ostrowski wrote:
> I am glad to hear that mentioned patch fixed your issue.
> Small clarification - amdgpu is not designed to support
> PREEMPT_RT flag, but it was still worth to fix as obvious regression.

PREEMPT_RT is not a flag. It's a valid supported preemption model and
you have to support it whether you like it or not. 

Please fix your CI to test with CONFIG_PREEMPT_RT=y so future issues
like that can be avoided.

Thanks,

        tglx
