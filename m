Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4920C49B
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379553; cv=none; b=elIy+p1v8vnBN0V1bndxIXWVCa3f7rUdjbxOhaiK/cDOnh5ZlJA/gaUXVSQWNK2CptgciK7uXgS3d9KsOnVTNDCCCOLxsIrkhBkQcSC6fCEjnq/1SOTlayVtjQ7OjdbU6sC6NPMTpJfaekLjTo4nBzdbzx0wtUzV5SLA8Jnj+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379553; c=relaxed/simple;
	bh=YjUIn4lJH9lxQ8Q4UTyt60Z0ILgIfgW9XxjAH/hQKDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggyCHegwzj+MGm2UmoplxOVE8Rjs8Ff27D2Pk30XKLu3k4f5a7DPHQErJkOREn+UN18uVqM4zZNS9Zhq4xZfTXuo+w0D+CaZjGYDMt+iN85LlMUs0UhAVadgI5G0CXTptoA1meiySO0SQKMO/sb84tzC7BAZIRsuO1cui4rlQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t274u3TB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bmiY8Scv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t274u3TB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bmiY8Scv"
Date: Wed, 12 Feb 2025 17:59:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739379549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9W2ZftG6e/0aVD6yOjnyHLbtkoAEjsTBWGZ2zWsfjdk=;
	b=t274u3TB6jKJqaXtnDedidIZD/DcwXdagY2m/N1pbmL8oho/c87UFCeL0UNU1RXwP8iV2N
	wgpe7XkqWXJQwsMc+x3KlDa5Rcf2Hxuw/S/dPFWBWX1A56x9+95+j0ospTPCidTk+Rglz9
	SeESlSnDBeJTvoTNkLJOAvNgcwfdMTZdL0+6xk6OpfNEj6AUtf1WkXuVpcfU0okUj+Ga07
	CGXPcmTcPes+mv27UNsii++RQv3bJCxFvGymRUU3nkIFibhmOb9KAc2ny2Cy8RE9Q0a4FQ
	QvbIudsEi5quEvaPuxksYzLRYv5wNIIPbeLbhxZrkB9C69NeL6D5b0416sDOrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739379549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9W2ZftG6e/0aVD6yOjnyHLbtkoAEjsTBWGZ2zWsfjdk=;
	b=bmiY8Scvm07JG2jzYsc0u4DRMHr8qUvURIAbuZ0jjHrD2AJAjP1Uy1ZmUtQsgC1+4xDulI
	9gbi6vj3HH5OR+Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212165908.DoNnHJ5v@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212114531.4e95ffe7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212114531.4e95ffe7@gandalf.local.home>

On 2025-02-12 11:45:31 [-0500], Steven Rostedt wrote:
> 
> Shouldn't the spin_lock_irq*() variants for PREEMPT_RT also disable local_bh?

Better not. The consequences sure wouldn't be funny.

Sebastian
