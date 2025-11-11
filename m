Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875F26ED4E
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Nov 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876758; cv=none; b=lKhLzAPsY/Um6yvkbNVcTPki/D4GhH7pPjuEcw0nkVvwneR2imc0d56aKCvbjpVCfQmlGMqz8/UWUMKFQdG8vh53wiTck1Z++Tj9E87wxZm4rK0SUsPWwvAgIJNPsTdTCKnKSdSxMXNZslutST0ockQgNO3mk/uLJlcVmX4az/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876758; c=relaxed/simple;
	bh=2rmpTLReU9q1zOb79DgRSjQTD1gPeY6gQB5TxoAd0Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM9NfpwwJatvw795otm7/2M3GOSHeTHYYCuk+6MArneMQvL8nAEqUhMLjyJo3wB1XUPSIeVgU8nRa2gN/cWlXvh0GyOOxTqQjUWhONv08aNPJ4ico1iuy7D4TXVIGe01HH7Bbya77iGqiVfW2k2brkn71ZwS6j8b+ieZAqYuzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8Fg/JFt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hrFePxJX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8Fg/JFt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hrFePxJX"
Date: Tue, 11 Nov 2025 16:59:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762876755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWIg+G3NtGN000xQkIjWdpW8Cxq1lptIVIx/rlEItlk=;
	b=S8Fg/JFtyqdQ9Ni5R985O+MeLbhqKsIILBK2ERgFNnj3MGyEh4tfFNYMtZlICbIdIVHScI
	R1Vj+AZmVF4RdvIkpugUagbStaY5FroR8Xc+H3uXfbb/86UYbJIPwDuE6T17/k2QfOSObN
	hsMzYD6oFuvUxtc1n5HAE2kPPlqguAgmG8pVrGolbv9l/njAwrNSNQEULN87oyZ0RjBESK
	VbPw4rX57z1x6i5lWGlGQD/5RbT9cI7kLDNsxp6fHs8xGlWDZANVn5wpAJI0vbERf//fLU
	v2wBtjYSFu3ACH25IbhGYs5K8b/VB+9bWVWM0k1Efe8x9qH1nUv9JAloVd1+9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762876755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWIg+G3NtGN000xQkIjWdpW8Cxq1lptIVIx/rlEItlk=;
	b=hrFePxJXGK4DRratCzXtIVSUrnmS9FUkddU/Mtda/4okTbJc3K6UjQlkJqJ1c8hPAUBZWq
	rdr3/jp1D8NyWABQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 0/5] ARM: Remaining PREEMPT_RT bits
Message-ID: <20251111155913.vH-cxYha@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
 <8d7c55f0-ba20-411c-93c7-bb354614c0df@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d7c55f0-ba20-411c-93c7-bb354614c0df@app.fastmail.com>

On 2025-11-11 16:16:52 [+0100], Arnd Bergmann wrote:
> Looks all good to me.
> 
> Please send the series to patches@armlinux.org.uk according to the
> description at https://www.arm.linux.org.uk/developer/patches/info.php
> 
> You can use
> 
> $ git send-email --add-header=\"KernelVersion: $(git describe --abbrev=0)\" --to="patches@arm.linux.org.uk" --suppress-cc=all

Just did so, thank you.

>      Arnd

Sebastian
