Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBE3CB2E7
	for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533571; cv=none; b=QMzmFAKVZv6X84a6dcsSmI/I3lkwxLS04K75Vb0R54P22ccELZkG73J+r+rV1vBNjkc9ucuOpOzTIPtvQwJ2qN1mpyQz78ZQCWLoHIjmloKMUQqc0Qamf+TppWe1iVpUSUrMZm0pF2EckpXbPR67P1tnxVETYFqqaOZlcNop67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533571; c=relaxed/simple;
	bh=HL0anKCCNHS8lBH/DXkYwepz3RpLYqdwtzdHZ34oLBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKwD3tNSjfNY5UOJqoL4nVdFee3uTbSTCvw7hz+D+iI0muM1FCUfbZBeipRmfYbNJiEjQ6G3vGWbv8I1musIVAJH8zO5svxqxrDHN+s+WQADK9+ZfptIR7iqUYH1rwep5ZgGpaehZFaw3/jYjlTU6Org5rsqFVGT1G+2kbyggwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cMnKCGCz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rChR4oaq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cMnKCGCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rChR4oaq"
Date: Mon, 20 Jul 2026 09:46:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784533568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HL0anKCCNHS8lBH/DXkYwepz3RpLYqdwtzdHZ34oLBY=;
	b=cMnKCGCzfsQUGrZ5SRzflc8wn458KWZ/7jKX5dyNyuAJEULrznVC/iGZ0NKv4FJcuL6K6D
	jV7y8x5ukz6M3arA4IVE80xuYi5BNWvYikffz+XGB+TN5wpYc4/jzczpIgfBdZmfDmlv/F
	CT+EmncgDkN+wUKDgMw6aNjy0gooKdLtUfvO0bV+4zQGCGWkTBbvjhn0CzG5fdNbTGo+6X
	D9ZyifBixOSPDa/R/vi5cFSWzNA6H7AqQVtaMV3K44W2gzg4FL5lwi9pkPKHosEo7UOhbn
	YV65FpjGmvlEobAjlBnBmhp871bCcCv98JIHpTR4ZpZbJSgtnN+Gz2UwuTEXJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784533568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HL0anKCCNHS8lBH/DXkYwepz3RpLYqdwtzdHZ34oLBY=;
	b=rChR4oaqIlQ08LSl0w5be1BICsXYDLIiPgt59UlSncLC2yLwjhSFJjubzzzynntA6+aqZ4
	brCh4cmVdq2jeqDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, arnd@arndb.de,
	clrkwllms@kernel.org, liaohua4@huawei.com, lilinjie8@huawei.com,
	linusw@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <20260720074607.4QR_L3Gh@linutronix.de>
References: <20260629075726.McX9yWi1@linutronix.de>
 <20260629083150.72460-1-xieyuanbin1@huawei.com>
 <20260629094022.Ml4PCqsB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629094022.Ml4PCqsB@linutronix.de>

On 2026-06-29 11:40:22 [+0200], To Xie Yuanbin wrote:
> On 2026-06-29 16:31:50 [+0800], Xie Yuanbin wrote:
> > Thanks. So, can I take it that you agree with the first one?

I am going to apply the initial patch to my RT tree so it does not get
lost. This needs however to be routed via Russell.

Sebastian
