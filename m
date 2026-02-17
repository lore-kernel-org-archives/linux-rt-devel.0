Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1D31A7F6
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322225; cv=none; b=kyI5MqecJPj8S7bFiQW4D3PHXf0MhdLcnES4Knn1/h/YVR/hMmE+ckfxmoewgLdtNP17N35DG9YUR7QHu/8LsrrtqNNcXp+NUfiVA2K/uGg88irVnXwr7qP/LEPSUd9xc6dQqhYD1QMcuW+NoukTP0O3Vw0oePLrRTL7IPv7Chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322225; c=relaxed/simple;
	bh=hkerWcKdIcCqzfDLpw1AgO0apvcqwNOcWfx9p2C4e3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fojb1PCASuOeLZw0SUqME5+1ou+BdggMyDLxpM7j4wRV1Scr7K1hqW67EzhvcQpuCXDvpG+t+401OiZYqgctCpUjm4HCHl4fJAvDdcLWUOh0YI803xLljN7fcHi9bxzklFZ7C8FAZfs756QblL1DbLG1AB9EDnQMNnfoRfCnLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wjA392KX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqCD71ok; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjA392KX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqCD71ok"
Date: Tue, 17 Feb 2026 10:57:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771322222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=muhHTqVma6ZzeSs4ibzV6CiJ+E+n6aPPxXTE6apN0OI=;
	b=wjA392KX/CqQfg51m3a2a9NlyUP4zqQvSpNgBm+dFDc7JEm4PAM5I7df4CPM4dq03qWijY
	UJtvf3boNoorA0E/KLU2fpIO2Yjoa9SBKmQ9CJj9UyL3mpGxd86VVDwGYILm8in6nLG2oU
	YRI/xbaUOF6eu8gGiOPJxxifMuFGUL6FXxS5BpnBDMBxy9EPmIUTQo9gBZmjOk3+XoBxWP
	VLRQgzm2+LfFpqC58pZLIHOXGzarpxpXzpGkyGwWQX6GKwT+yYDo9DVjCDGTeb89QgXSKU
	a3soRH1dTfxyxcy3zpQPIu/FDbl6afByjePfvttdd7Nc0xt1P+BsVywzY7VrKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771322222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=muhHTqVma6ZzeSs4ibzV6CiJ+E+n6aPPxXTE6apN0OI=;
	b=iqCD71okUOYa3n6Yo8eFIz3XkiBMtvbUTDnqud4vNcsvLHTN8PiiAPImO51Ewdb3bB21eU
	9oPCFra+tFlBLpDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260217095700.SjYjM8RO@linutronix.de>
References: <20260216134333.412332-1-spasswolf@web.de>
 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
 <20260216153745.CA3__zRc@linutronix.de>
 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
 <20260217071952.WCXLGs5-@linutronix.de>
 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80114792206dc00d0099f00999a209e717debb12.camel@web.de>

On 2026-02-17 09:56:48 [+0100], Bert Karwatzki wrote:
> Am Dienstag, dem 17.02.2026 um 08:19 +0100 schrieb Sebastian Andrzej Siewior:
> > On 2026-02-17 00:48:25 [+0100], Bert Karwatzki wrote:
> > > The problem seems to be that different preemtible threads try to send skbs. 
> > 
> > This does not matter because the counter is per-thread not per-CPU. 
> 
> The "Dead loop on virtual device" messages is not printed because dev_xmit_recursion()
> returns true, but because READ_ONCE(txq->xmit_lock_owner) == cpu.

Ach, so it is not the recursion, it is the assigned CPU.
This is assigned via __netif_tx_lock(). Here we somehow lack the
expected synchronisation. So the queue should be locked but not by the
caller.

> Here's the backtrace:

thanks.

> Bert Karwatzki

Sebastian
