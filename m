Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6983C9ED6;
	Mon, 20 Jul 2026 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533434; cv=none; b=QOodTYC2fU3ZNYPHsMATSI857trJagTgWAaUT9mc5fr6Mxgn5PUg9H5vaeL/eMwQCxYOIWirwpz7/81LbCWbqAkVsYHwkiPm4+Jsv5F2dQXWK/enb+QSYEDKvgP/UyKXDmYGpU7mXVoqcBV3CDjqE6JafRFntVV0HjhZA3k6QcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533434; c=relaxed/simple;
	bh=P59J3sFw4Ktlk7W6cmz7yyJMof0m1GTXvhAdpMI9Ce4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqviIkvECEY+RxEsHBEEc4l94nMK8gLGQ298K+ybDZWOIDIVXtNScjbcIRzdzlvdWC6RnnXFSBN2qfRJYndzjStes6FNxcwIjEhxOtz3yV8XGhVrk1W8eC0md8c0VFln4rHS3YhWWF8/eK7QVebOHlKHrRKmxlm1NOebT/ey+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1eHjoIz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iEcolkB9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1eHjoIz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iEcolkB9"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784533422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P1LLu9Ds9izc1amBmSyEC0AOO+Ou11Oihr1/XBhAFxA=;
	b=G1eHjoIzuuEaZ4/hv4EkD4SZH5CfkOcE9hFDtS2C0GjKK/jZyJeLyM7h1zgoQy8WFu3VKN
	lr/XyBdHllti5ua6ynu9KjaGnT0uMuoA/wEtssYFGOkehHQCAdqXoaa9m0S/5Xd1pUTbRC
	lWd067Uc9HM2h3uZdADX9NJViAudKAP0/1xJffr0JRNwSYi+T0WesrMvNCrdRi7sPgQLjy
	Gml87b71mG/Dyto8F/IfKONxOsZij3/OReQDmLaunOGsOFZA7abYpYZ/9+NA+sPXof0BLj
	WtAi65DtagByel1E0+k4xER2g7LeN/+Qt8YsZXLJd+OmtS1wNpeE04jF6oa88Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784533422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P1LLu9Ds9izc1amBmSyEC0AOO+Ou11Oihr1/XBhAFxA=;
	b=iEcolkB97FmB3b9SDcRMH298WwGiKnfeQcUf91cajRHR1LCDLWtMT5gUXogEQKHph/Xb+I
	/xMVI4iGbXxWcnDA==
To: sashiko-reviews@lists.linux.dev
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] af_unix: Clean up unix_schedule_gc()
In-Reply-To: <20260718062736.C97A31F00A3A@smtp.kernel.org>
References: <cover.1784268931.git.namcao@linutronix.de>
 <548b1b624b13fc2582b1236a2c656e4261eb2525.1784268931.git.namcao@linutronix.de>
 <20260718062736.C97A31F00A3A@smtp.kernel.org>
Date: Mon, 20 Jul 2026 09:43:41 +0200
Message-ID: <875x2af6mq.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:
> [Severity: High]
> Does this call trigger the garbage collector for every exiting task in the
> system?
>
> If an unprivileged user creates a live AF_UNIX cyclic reference and leaves
> them open, while queueing a large number of normal inflight sockets up to
> RLIMIT_NOFILE, the live cycle causes unix_graph_state to persistently be
> UNIX_GRAPH_CYCLIC.
>
> Every task exit would then constantly queue unix_gc_work, which executes
> unix_walk_scc_fast() under the unix_gc_lock spinlock, iterating over all
> inflight sockets:
>
> net/unix/garbage.c:unix_walk_scc_fast() {
>     ...
>     while (!list_empty(&unix_unvisited_vertices)) {
>     ...
> }
>
> Could this O(N) loop iterating over all inflight sockets while holding the
> unix_gc_lock cause severe lock contention and a system-wide performance
> degradation for any AF_UNIX operations like sendmsg and recvmsg that block
> on this lock?

Yes. But this is also a pre-existing issue. An unprivileged user can
already create a huge live circle, and then repeatedly create and close
a AF_UNIX socket which constantly schedules the garbage collector.

Perhaps we should think about a GC scheduling policy. Perhaps like other
garbage collector designs which get scheduled when memory runs low, or
maybe periodic? I can put this on my todo list.

Nam
