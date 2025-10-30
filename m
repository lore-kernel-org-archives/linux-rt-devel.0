Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4B19E99F
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809025; cv=none; b=Y50V6dG2cRhYfYSlTjZ6Ak5NNzKW9ZFQSTXLuD9hCXrT5BpNODli82NC87CP+sIwtKcu+2YDpJgbZ8UP6yRRGCswaWm8QjQpSvG2YvQbr6Mz6fGhi53wXDqt8IpbI4jLKJ+RgiZRRATf5IvMCf2tO/c5WFc5t+bqI8Wk2l2xVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809025; c=relaxed/simple;
	bh=sKs0N99xA1oBZIoPfSPsHZDtQVAQtJxitEj9BbZkw+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUmStRpKV5T0FM3XG5gG6l38koPCybIaFQfntk81Pmvh20PObP8XNubvjLjqCTUAPJ8wecwj0b/wPnsSZVbhgd5bMJnj9UpsuE73EmXfdCtEsYnxThXtCnp0Cm66OH58ZReLBzRUigsUbZxdIfS8VjAV4cEVMBaWajd+UVVoDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpct3k3r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRut4j+S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpct3k3r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRut4j+S"
Date: Thu, 30 Oct 2025 08:23:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761809021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0UKg1s0YVqcKspA8T+qvDLFzrwE2Nyk3FttwK4GUlA=;
	b=qpct3k3rVBvatgBKRTOxrZf5oB9Jqi5BsS/7afPd1iblyTUd9udc5xd5XKdb1bUC7nVWbj
	Ji9cFZniHZmIegtKRhjGzYAPlTvNEA+QNJKU84pZ6w41V6Bqd0AkERcutJIDWmNvo4eL62
	HBJYwDURGGDpjhSjQdBO9P+CI8ci5lccMqHG/tjcHCgZRO6xoJuSfyi5qG15ap4Te9ITug
	kk82e9AgyjaPlzEgZqrIVEmHJe4XIWBHk1WjyLRg2qDyvVDTmPUjpZhY3yhgvdmmwGyymQ
	EDrx9jPTu7mY29wP9xKmAjASV8I+oSCXTYwLUAG5ZUbyfkcudZIvWQVlV9eXyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761809021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0UKg1s0YVqcKspA8T+qvDLFzrwE2Nyk3FttwK4GUlA=;
	b=MRut4j+SlWicT4fAROkg13ftS7GmIdFBbYQJE9Nok0ppJzqZKtgAPKtniYY1iNkqEGSKTX
	7dZ+lGMo0vbe4YBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, linux@armlinux.org.uk,
	tglx@linutronix.de
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <20251030072339.63vdFNo3@linutronix.de>
References: <20251029155918.503060-5-bigeasy@linutronix.de>
 <20251030023959.5416-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030023959.5416-1-xieyuanbin1@huawei.com>

On 2025-10-30 10:39:59 [+0800], Xie Yuanbin wrote:
> On Wed, 29 Oct 2025 16:59:17 +0100, Thomas Gleixner wrote:
> > jump-labels are used to efficiently switch between two possible code
> > paths. To achieve this, stop_machine() is used to keep the CPU in a
> > known state while the opcode is modified. The usage of stop_machine()
> > here leads to large latency spikes which can be observed on PREEMPT_RT.
> >
> > Jump labels may change the target during runtime and are not restricted
> > to debug or "configuration/ setup" part of a PREEMPT_RT system where
> > high latencies could be defined as acceptable.
> >
> > Disable jump-label support on a PREEMPT_RT system.
> 
> This sounds like a performance issue rather than a feature issue.
> Banning users from using the jump label because of a performance problem
> seems like throwing the baby out with the bathwater.
> Perhaps we could add a config like CONFIG_ARM_JUMP_LABEL_RT_FORCE that
> allows users to select, and inform users in the description about
> potential latency.

It is not a performance issue, it is a latency issue. If the scheduling
latency increases by 300us because of this then the PREEMPT_RT system
becomes worthless.

> Xie Yuanbin

Sebastian
