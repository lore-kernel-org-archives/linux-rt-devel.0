Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAD3976BE
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905400; cv=none; b=aRATyIeadQH4HQ85/X/DenQhqPlWBBkxljnsjyfhbWpddpg/11F91zayh0a5FnjZZO3cwdsCR8dkZTFiPdAsDDvamNtxXov8b5m92Ou0bwLS8rYEk1OL1lLAKKfpz7DbRw4muMH8dNUv29MrLEXG13VrIaBqYa9tN5omzdIrow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905400; c=relaxed/simple;
	bh=fbYLhlGmNgCMeSeHNjRfW9SqnWqIkBTJzP9saOGsq/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFSVqIG4B5J1FEDMore6uELZ1GFamd8M20NnWz2W48eqZN5z++nEpu4/egdYoDOUBWs3O75OguNMddbfkcl5MUKQUZKzuIh/LYHXpKG0ksCVZyRMiJYbEqLL4jrmU+vDVMzzSTd8NssSggbVKVyfg6UN4ATAAvy/0wKy+JQbSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWtYoei0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byu2h9ri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWtYoei0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byu2h9ri"
Date: Mon, 8 Jun 2026 09:56:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780905396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLdXDOMf5RLCBGLdG8oDd6JygqwG6pLOp9rTsYchorc=;
	b=JWtYoei0d1jHdZXNrtGox+Ea+jJBVLBajA/HpcyTgVkcl3M/7Jk0CfGPwszNxdJrJ3RXwf
	qFJkOs/xv7jpZUDVXuQRwJ3O9rWYc9cSS0QNzynfZRil027q57rAB8k8P1fagn8cgd86A1
	jFRkXw7e7cryXTWomInRRQ/Ud/ksw9M0aXsG5mIO+pBSpc5YZcTsNkriuVRxFaEMIihAn8
	DvbHdhnzn3nawWSvSmhNouVQ6XmreAq+I9F6i8PNyCil7bTDlj2ELdt+zMNcE5vYisB6Gx
	YgVT7pQHHfrnUKOFMPBHhxyH9/i+UwSQlBXJTKGNAe2W6KXCYTZe2VPdc4iX9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780905396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLdXDOMf5RLCBGLdG8oDd6JygqwG6pLOp9rTsYchorc=;
	b=byu2h9rivLLwWQMswYjay1NNDqmQ+tA8s9qv5YpD6GhWNKMKTY8gWLwdpe7mViZiqASDNX
	2qOQrjKU6t2exFBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6 0/2] debugobjects: Don't call fill_pool() in early
 boot hardirq context
Message-ID: <20260608075635.rxZK33EV@linutronix.de>
References: <20260608022222.723265-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608022222.723265-1-longman@redhat.com>

On 2026-06-07 22:22:20 [-0400], Waiman Long wrote:
>  v6:
>   - Break the v5 patch into 2 separate patches with the first patch just
>     adding a can_fill_pool() helper with no functional change as
>     suggested by Ingo.

V5 has been merged as of
	https://git.kernel.org/tip/0d046ae106255cba5eb83b23f78ee93f3620247d

Sebastian
