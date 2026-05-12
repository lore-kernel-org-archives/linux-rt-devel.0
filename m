Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA41C33DED5;
	Tue, 12 May 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572274; cv=none; b=rcdMBP2O/GFEbcVd8HIaObgz8mKbdr84HoxvEhgDgq+PvKsLyHzTvcYrhZqtOI9qvW1VkpmtPaB0477kBMfAkOoyjcHmYlj59cW3ggzLX5/n1kIrzOiKOjXMvsCrMqCaStPC+SMKR2vo2seh6HRfgPKGUvdslXovCIUz/sZx6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572274; c=relaxed/simple;
	bh=Gb+x4PzNxLGgsiGaidDCYH7meoCvR0Ctj/a/tCaKHhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+UkroefGh4EIHOwwghE6X8sYXBUgg59JjmJMliFFFcuMNkh1clxb+gPtPe9KN5ifgZLaml0DxZ5vNk2pTdhkCrTrP44MZapsfUAkYXsIziaeLWZlwfIhdQNU3aTXNkpAaxKcODbWkmROZX24NhVuVpRSgtR7RpvMggz1dGJlBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JQgaqW74; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JQgaqW74"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lm95ET8I3xzuu0kbvxD8jxWXvCQp5gyN34FZTW0MjLw=; b=JQgaqW74uMVCGsQuINosFra4oZ
	vBdw84Dzu13+5uCvSs5/W8BfvkOAW6B0C4tXh7nkXwXe5HFfpBAS5dzD0QPozCxpc4PObMTAFQarL
	7mO6tuuMiJzS3RjUUNXQ9kZS59hY3tV060EDjfIsHh6N4RUFZ5GwyBbroneitDmMKKTlu2PqYzB+7
	iJx3kCt8Gp+RoJvGT9g4t7yCGpXBsAYK/vOi5UY647d+2MliA6HHx948Kwgq1Ieq7Rs01x8+Sc468
	KCw7hu0nHYIHEyVD2x5x1Dz8tTHJ4AB5Z2yLAj5nk+n+rCE3o3qxwxRNs1qNo/B0JqHoFVfkozhsE
	jq9dAARw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMhtL-002E7w-1V;
	Tue, 12 May 2026 07:50:59 +0000
Date: Tue, 12 May 2026 00:50:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next 8/8] netconsole: move find_skb() from netpoll
Message-ID: <agLbgnaBSdNlELPj@gmail.com>
References: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
 <20260508-netconsole_split-v1-8-0f660e62841f@debian.org>
 <20260511183718.04781b86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511183718.04781b86@kernel.org>
X-Debian-User: leitao

On Mon, May 11, 2026 at 06:37:18PM -0700, Jakub Kicinski wrote:
> On Fri, 08 May 2026 06:29:22 -0700 Breno Leitao wrote:
> > +EXPORT_SYMBOL_GPL(zap_completion_queue);
> 
> We should probably rename it to add an appropriate prefix.
> netpoll_ or net_ ? And maybe export it as NETDEV_INTERNAL?

Ack, and this will continue to be exposed by netpoll, even when the
whole SKB pool is moved from netpoll to netconsole. I will udpate.

Thanks
--breno
