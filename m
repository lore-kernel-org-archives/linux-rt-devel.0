Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7204EBAFA
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Sep 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451723; cv=none; b=WZAKQqaAxzvJOvfh4cdW+ycs6LaOlYl1JxM3fT1c9U6z3FKqM97PrzIEhNx54UBY8styIwGt/K0XYGAwjKPZNv7OyP33GwsvK+OGWPMaxKr0bAXZbrrrfJihsgOlJcjlsfSysVgK9AOanq7KryrFhoY7V+BjWRfnZz/CbR7hJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451723; c=relaxed/simple;
	bh=4oA2ywCPd8NGII4zWEzxdJph168ZmnsbCplTo/dJbos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vox3uOHaO3QHGkIqgdGb44R1y9+u+5ubkFqPDmabH6vgto+AEmlvstJuQmDoNIVni64+BJTlnZeLQ788eNfs6KK3QqoA3P85e62hqzMFAS08k9Wq/8McP3/IrW6FhdX42Z24A+4l30sbhdK0h7eb+qLBNzrJfzomG/7/Oe+/GqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lqeLfxiQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JV1iVuHv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lqeLfxiQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JV1iVuHv"
Date: Thu, 3 Sep 2026 18:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788451720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4oA2ywCPd8NGII4zWEzxdJph168ZmnsbCplTo/dJbos=;
	b=lqeLfxiQhfz/6LX6Jqmk/W4zQm4quT5323KDffCBEVsYehfVqu0TkKf7tuuW/FNF1Vt6RK
	inSWjY+8A2IIm41+KD4VSHmDA8CvblpA7J6PL9AC3qh0dVfEY3fIf1/5AykYv5OMGy4bmf
	Xmd2AIgbaAb9aUX18ikTvUhT/PVfLO8Y1xwN9/bC7EJbFKGwpg3GqVf42ydki38cHwu5yr
	ChTUzXqBBybbdZlkF+sPfhtQH/QSfvPYznCzKzKN+Oo+zoAwBluE8Jsy7VTAv8eEM1iCUG
	FrqYDhOWGaZspl3bmWa04cKEpktQRLIusoN6Ll2uCT7v7vLxIE6UeX5Ox3p8JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788451720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4oA2ywCPd8NGII4zWEzxdJph168ZmnsbCplTo/dJbos=;
	b=JV1iVuHvk2EtKcoMge0kTzADPeu+FZNgysyuB1Urk5W2yZYBP2z2PFwrCODIbOyh4v2uar
	w9dM3yXDIgFhpKDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <20260903160839.MSDyqgNp@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260814090304.558901F0155A@smtp.kernel.org>
 <20260814092049.EHIf1eeX@linutronix.de>
 <apmWjJquEQIHeFrW@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apmWjJquEQIHeFrW@redhat.com>

On 2026-09-03 12:47:24 [-0300], Luis Claudio R. Goncalves wrote:
> Sebastian, do you intend to perform any extra work on this patch or is it
> ready for consumption? I have been using this change in test kernels for a
> while now and haven't had a single problem so far.

I think it is okay. I just poked on the original patch checking if this
is okay.

> Best,
> Luis

Sebastian
