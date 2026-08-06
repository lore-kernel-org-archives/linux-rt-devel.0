Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAAB3E63A4
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Aug 2026 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003363; cv=none; b=O2EfNi6JudGguUYKORmNbhl+TKaJoxCVUflPmaqTxVKwUu48Pj/JOMshsT8aQZ7U3+A7jhzYvaUCfWnEs35JDoDDaloJzxcE76Kc+bDNmqEGucbq7Rt9UHRrA1HaxAXDIMaCoHuCc+IPFYZqZuR7ryOmJ15qD6LJ117anEIEmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003363; c=relaxed/simple;
	bh=orrb8uAa7KvJjb6Ri3VMbD7Djzwl7d8TqNhSsyKUvDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhFb8v6rUYfijsjHk0aV9v2Ml3ZWYZNHoqqwKVji3gnY+ZtZFjDXHNdLMHe2oKdHgznoQpUQWjif5nWh1ai34fA6p4debPPwzFq5+0D2TnyLoZR9/iShNugP1V5D+vOd/6kHwn6INmUO917tcDUpwVh4F+nGHFPiDNyxjvsSUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rTCiWdMY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PlF25EdF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rTCiWdMY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PlF25EdF"
Date: Thu, 6 Aug 2026 10:02:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786003360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orrb8uAa7KvJjb6Ri3VMbD7Djzwl7d8TqNhSsyKUvDo=;
	b=rTCiWdMYwTg3AdL0umlWZMfCwxHA8rx3+tGcbAetMIKchqjQZPE6ynzAMcqO3sctOqFiDU
	iMVFcJv/a7IesG2vvO2dAKaZOUBEON9PULX7r1aw8ay/QHaJ7kZyyUys8mf6syq9R7K5To
	1qkiun5o0TezJL8W1YZE2S2W/+JCFbIf9Zul4si98v5F2rlB+gtFzZLrCVNtIxXehEhkyv
	vitDwApMDx9Uwzdy5l9voe7jLelIP/YcT6HJUzdgUYulki3nzvUYvXxrc9RpRM0atHPtMp
	iAY6R38yP+EUlIxqIOQDD6Gw0CDYh4ZZo8/3ruIliiChAx3SoJk2Lkst/D7W7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786003360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orrb8uAa7KvJjb6Ri3VMbD7Djzwl7d8TqNhSsyKUvDo=;
	b=PlF25EdFSBKuwj+ZTAYXmsKrIvDEjtzSECZW6cJehC0jkI/GiMrVfl+Qa8luVju4tsy8kE
	YRq5YIeFG5i2e2CQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <anQ_nfveudT4ax7v@lx-t490>
References: <20260804141541.747704-1-darwi@linutronix.de>
 <20260804141541.747704-2-darwi@linutronix.de>
 <87pkzwnylm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkzwnylm.fsf@trenco.lwn.net>


On Wed, 05 Aug 2026, Jonathan Corbet wrote:
>
> So would you like me to pick this up in the docs tree
>

Yes, please; through docs.

Thanks!
Ahmed
