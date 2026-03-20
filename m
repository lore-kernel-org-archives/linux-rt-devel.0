Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B82FFF81
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Mar 2026 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992153; cv=none; b=aWoMUF7PHvNne2ZePk3Uv0ACAY7a+1+dw1l9aFqN5s4nuXngA3ZscC4ZJPkWZfp8ajBFFdrn8YvrSQK+g51GMM4lcFKSqppmoNYsuId2g6tvJS/pzYPzoWDSqYRTsGonpyVWimLtdbwWSlr+5I4VbK4xfvzsJOPBwCsHVNMyXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992153; c=relaxed/simple;
	bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyE+qvF838EY9wsAm5i/xT6YkedUtHZ29dgULA7DjP4Zc26oivAFF4QM3Tj0VnrnOPQetwDe9/smcfPy0kVQ8Ituc9Wr5kowkxysu580w9lYNNWtiDs/iPTDoM0pBqjsT91dOHWx7jJSLsuSfAYhPkSpVqtYz0eAxXh7ajTbXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8iAz9sM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgNGs6Co; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8iAz9sM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgNGs6Co"
Date: Fri, 20 Mar 2026 08:35:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773992149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
	b=y8iAz9sMFwZkvlKFSdTHirwcWs3fvhGdg5WOKx0k0FboglbYAI2uVBDTeJ4HudeZaucFbS
	mEubXpZlkuLgCARmp1E9jHuSo5VDW9abwOyuhJKAeFYc+ss8Owc8b5RBpfPoTFD3Yphu34
	iG7fSXsV5KHDfhH6reFd0CZqFR8vjDX/TyBs8LpLIkCuRxHgi2TC7w6bVkIdT0zZDQraeC
	ilA++MWsRDx0V/p9ZibE+vCz04512ddMJgdYhIL5rTOu/V7spGMG0b7KbC1J03GEd0g7T5
	D3rlgWe9B6PyAiIYJ6l0MQATSM5NCQoGQsVKXtvlj8lHsMDLUH/ZGpA3alXPUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773992149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
	b=qgNGs6CoO3SkzuiELhVxh1HMQGJLy4PnEV508XLHDphAOGU1JvTy8pDdYgOhJ3QcpHnm4l
	vPwlXd6i/0uW63BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, sgzhang@google.com,
	boolli@google.com
Subject: Re: [PATCH iwl-net v2 0/3] idpf: virtchnl locking and async fixes
Message-ID: <20260320073547.yqDmYQ49@linutronix.de>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319211335.23236-1-emil.s.tantilov@intel.com>

On 2026-03-19 14:13:32 [-0700], Emil Tantilov wrote:
> The main change in this series is the introduction of local spinlock_t
> which replaces the previous use of completion's raw spinlock. This allows
> us to make consistent use of the xn_bm_lock when accessing the free_xn_bm
> bitmap, while also avoiding nested raw/bh spinlock issue on PREEMPT_RT
> kernels. Additionally, we ensure that the payload size is set before
> invoking the async handler, to make sure it doesn't error out prematurely
> due to invalid size check.

Nice.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
