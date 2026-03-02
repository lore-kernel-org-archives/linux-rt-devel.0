Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F335C183
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449059; cv=none; b=ljs36NaeAP9Z5W8fe0rKs2/HqM3nZK7lfz/g+B5MdQjMebrU6QqfHQvINjnbyJeYNiAk/iI/qBYe6z9agtSGVFop+5PSrYu7AsV5RD+FQ1li/Xb5iua6huS6Xr2vDRKf5IATA+4Q+fy/zsF2rGv+ypf7zOsfbZDIjMBy4a2UjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449059; c=relaxed/simple;
	bh=+AnJNPzMIQ8xBj5/voqFw6Th5VviN+A1hNFaPgYCPSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOOqgPd7UjV2vYVAOiJo5KCO4S9ml4Tq0oBZuopAaVGJRGFQeot6ZZSE5aQem2sUxQCLmtlSwAamEuz0X7wbIIBVbwIDZT3m0LvGrO21sLT3HYBHx3lsQTVrE7VuPMnWVR098FNaeIQZIjmJTEQ2SZwy1ZokuFuaRm2baN7PnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XcnqmGiU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EB1GAL1u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XcnqmGiU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EB1GAL1u"
Date: Mon, 2 Mar 2026 11:57:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772449056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0fDz0lBXw5R9sgjv0ijWt32KF6cVleQgryMyN+mCVw=;
	b=XcnqmGiUCnqZysSQRAjGu+NL+G2ZFfMZ/4SeF0FOSv7p6czdyTtYLjvNN/WuRXXRdfhsch
	PPSE/gP8VA3b6gYgcAraIy3aZAHHldlQhToSm+Bu8uLgSnTGNXsPJaD9nDjOcHQgks5P2f
	PHKlicrHiDbejgKy0cekdq31120hymzGnF71o+e/MCoatZ65Aj8nZQmdHHUZwoo4pYfI1X
	fI13t0x9rwqDBR4x0M66VlXeBnxg6qWqATC6q1+VzIwS+MOe4AiL2SAhsMVgq/it7ob/iM
	RbhlZhgznV1E/VojxmvT+cWmctrW7Vz11T/NgTXTW1ZXXJ1gTSGlanVC1VLvPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772449056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0fDz0lBXw5R9sgjv0ijWt32KF6cVleQgryMyN+mCVw=;
	b=EB1GAL1ufc91SpePDQHdu8vYrJ1e9hx04f8dGn+eEasNYCJ1GOuNOsBRLVEebkUbhe8L0M
	iXeuxPfppNJrRJDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/6] ARM: cleanup fault handling
Message-ID: <20260302105735.Roqcqp6h@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>

On 2026-02-27 15:18:26 [+0000], Russell King (Oracle) wrote:
> Hi,
Hi,

> This series cleans up the 32-bit ARM fault handling:
> 
> 1. ensure a consistent IRQ state in the user fault processing path.
> 2. split vmalloc fault processing in a similar way to x86
> 3. move is_..._fault() to the local fault.h header file
> 4. update the FSR deifnitions using BIT() and GENMASK()
> 5. move LPAE/non-LPAE specific FSR bits/masks along side users
> 6. get rid of #ifdefs within is_..._fault() by providing a LPAE
>    and non-LPAE versions.

Thank you Russell. With this series (notably #1) the PREEMPT_RT support
can be enabled. Would you mind adding "ARM: Allow to enable RT" from
	https://lore.kernel.org/all/20260226111742.3598421-3-bigeasy@linutronix.de/

to the series/ merge it with it? Or should I just send it to your patch
system?

Sebastian
