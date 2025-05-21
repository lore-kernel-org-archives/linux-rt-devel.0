Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D4280019
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 May 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843119; cv=none; b=EhEw/qLtC4Uu47IVfj664VxzYSgj1ZSSGjsMOewExDe7Uz9nz51bwXtHqU1aGhoTFWB0KKZCZRFVpQa1Cti2SG+9/r4sopgonZXRVZwOdisVDANIX/ilkYlMVAkDCH2nzlpIuMtRc6fBe+s6KFD33EVT5tnHG9nHXpocSqLMjTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843119; c=relaxed/simple;
	bh=SbFSyj1iYbULqAsNnPRoOnLQK6wLPvxvnSYBvWw3chc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnaI4S9yCiUeswoxQSnRXtkSLzFjYTJhQp8bix+p+ZgjqRAvRD5sW7E/P3rQ+mjeCuk3kUNhlO4tPJmnKqMuVxEQy5ht8Zecd4JQAoWiC/qCoMkpetUUNbaR8NveA6XXrwpvNXIjZaEAAMH/waOKOH7PqBJzdp67XPCNSLRcVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ZUPKp/e0; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ZUPKp/e0; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ZUPKp/e0";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ZUPKp/e0"
Received: by mail.netfilter.org (Postfix, from userid 109)
	id F28E4606CA; Wed, 21 May 2025 17:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747843115;
	bh=wTjKnDdoSGwycb/dFNUbzHbZLKjSFoeHcl89Onil37A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUPKp/e0O7F16jmjzHl3Ar1Bu4EW/syC5V5QWMOSldTdI7K91RalcnXw4OVUikXsn
	 Fun6VLph3nt4J6kMqjNtPmFFRWepJFKor3sY+YkcUquBvc8RiSsguiRnQ4L/3XgvGX
	 CTwJdTpSNUqEDyaNDASOk8N/OMQF6BFchpazMMu7BZw+jJ7ppntql+jRoialyhcRm5
	 Sn3hEXedQC+memQFx3wW9pbYgtT2AXkeybKag/nmJjTd1ghLeLp3tGNrzb7jADF8it
	 x88JknIaOr3E903Qs0EEfAOWMWeriHp9aQMPhfdJwba8/cihC4WjcN19jtZdyrgNHq
	 L87osLRhyTwhA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E4674602EA;
	Wed, 21 May 2025 17:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747843115;
	bh=wTjKnDdoSGwycb/dFNUbzHbZLKjSFoeHcl89Onil37A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUPKp/e0O7F16jmjzHl3Ar1Bu4EW/syC5V5QWMOSldTdI7K91RalcnXw4OVUikXsn
	 Fun6VLph3nt4J6kMqjNtPmFFRWepJFKor3sY+YkcUquBvc8RiSsguiRnQ4L/3XgvGX
	 CTwJdTpSNUqEDyaNDASOk8N/OMQF6BFchpazMMu7BZw+jJ7ppntql+jRoialyhcRm5
	 Sn3hEXedQC+memQFx3wW9pbYgtT2AXkeybKag/nmJjTd1ghLeLp3tGNrzb7jADF8it
	 x88JknIaOr3E903Qs0EEfAOWMWeriHp9aQMPhfdJwba8/cihC4WjcN19jtZdyrgNHq
	 L87osLRhyTwhA==
Date: Wed, 21 May 2025 17:58:31 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-rt-devel@lists.linux.dev,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH nf-next v1 0/3] netfilter: Cover more per-CPU storage
 with local nested BH locking.
Message-ID: <aC34JyYurHyf0HRk@calendula>
References: <20250512102846.234111-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512102846.234111-1-bigeasy@linutronix.de>

On Mon, May 12, 2025 at 12:28:43PM +0200, Sebastian Andrzej Siewior wrote:
> I was looking at the build-time defined per-CPU variables in netfilter
> and added the needed local-BH-locks in order to be able to remove the
> current per-CPU lock in local_bh_disable() on PREMPT_RT.
> NF wise nft_set_pipapo is missing but this requires some core changes so
> I need to postspone it for now.
> 
> This has been split out of the networking series which was sent earlier.
> Therefore the last patch (nf_dup_netdev) will likely clash with net-next
> due to changes in include/linux/netdevice_xmit.h (both add an entry).

Applied to nf-next, thanks.
