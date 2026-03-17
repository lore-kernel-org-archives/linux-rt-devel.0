Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62402222C5
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738058; cv=none; b=W4UWu+GFTsLw5Sijua537zn9rTEBgVQ1wbZnhvvXkquu+ae5rH+hmWm/8G+tiLg/n9LgXEQUjCYZdGRFCQLiJ9t8boUEQ2mGlDxUDM0J0iWx3nL4e9/X894QmS1+l29ACbo0jczBFVx3py3/eRkNFKal1D2pnmuDSd9F4OboLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738058; c=relaxed/simple;
	bh=ahQZAi5UZ/EMROopvwD9BjhlLPRYdS0kr3F4/01wIuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnXG9PnER8aVYo8CNVMmOXgpxQKm4mCSYCm1m8VYB5tkpdqTuZtvM3mwzN02pMdIJ0pnW0NEXKFtLGlRPTsMtkc/P0dOsp3IRArCxnhWEi4FgvSBkW/bh1r6zqhXHA1fLiMr7TmhXx5Qw6UySI4xhtIyw/u6RzgX9HRp63xMTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLQ3uN6Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbrxvkWh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLQ3uN6Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbrxvkWh"
Date: Tue, 17 Mar 2026 10:00:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773738056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojgsEh5obRGiSq1T5vrGWdb+Psz+QfVFhSaFy+wU9pg=;
	b=SLQ3uN6YVuQEg9kQON08A+uY+LzsYogYGBF7WzKqp6aoAg3T5JlIvHYGN8zvU3k3CdOnpZ
	2Jg2yvFNQTvabKDfBp7RhgeZjkGDUGRMQOn7ahIkopEC4k4woJfiAlRuusg77RPsfBXSf8
	cSkQUm6rAv6bJZurgBFWhvRDvfjkQgYJZWIble8dNDWYf/7CWXoQRniv26Z/HfU223GRTk
	AANgoYNmPEjUM+TnUB/5FmDTHaMTF54iirhdrsPimpfjHHNFnrsgpCNpgaE4IO1z/7Af6t
	RVkImuD7anFB2pqhswu8OXdF+RTUILeT4WknwXNjZ1r2X5GPdRAm+KIxVIPE+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773738056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojgsEh5obRGiSq1T5vrGWdb+Psz+QfVFhSaFy+wU9pg=;
	b=UbrxvkWhkDSOs+slId8jQ4SyV8kdAoHk7Q+mesTO1eEAkG3Da51ejvSL2WnUEuXdS8Fqll
	HSEHKiRrtHStMHAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, sgzhang@google.com,
	boolli@google.com
Subject: Re: [PATCH iwl-net 0/3] idpf: virtchnl locking and async fixes
Message-ID: <20260317090054.DuPZ6O0O@linutronix.de>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316232819.6872-1-emil.s.tantilov@intel.com>

On 2026-03-16 16:28:16 [-0700], Emil Tantilov wrote:
> The first patch in this series improves the locking around the setting
> and clearing of the free_xn_bm bitmap. Previously the lock was only
> taken during init shutdown and pop, but not the push function.
> 
> Patches 2 and 3 are fixes for the async handler. Patch 2 ensures the
> payload size is set before the async handler is called, and patch 3 fixes
> an sleeping bug due to nesting of raw/bh spinlocks.

Why is there a raw_spinlock_t? From a quick look a spinlock_t would do
just fine with not runtime change for !PREEMPT_RT.

Sebastian
