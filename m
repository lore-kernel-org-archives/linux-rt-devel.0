Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A033F8D6
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448625; cv=none; b=Otyna0QdkYYHh7vkdQ6Ll9dSnOMIn5BHonXIv5H19VVR7qFc89ofZcuITwlkVqtbSCwyiP16kHdME7+VrwJcha3QD8O88S3hZrW+jaIkFN6AOmyuyIqYU87AphCScqXQiC1mZlWL6+7lWT79npebpaDqEo/sOPypVz6znfjywgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448625; c=relaxed/simple;
	bh=ewhfka8P2w59iKUwO/XJcBbytcLBIKf8wxu3W+jPXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmURjLVYqAsvp71wtQxJfgEfGkzZwfr6s9Y+kfcS2LceAf7u2BMog+JkMYP9Fe5WJKHKTOSultW3cckdVobt4NE4+xtTahs7fzkTKfT8qYINO0BxAO0lfoJ3Wqkd0rxmilQbOvZAuPDWCiozVsomq5y+W2R/dNMTo1gjMcOM764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=luUvFsCR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wecf0X0Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="luUvFsCR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wecf0X0Q"
Date: Mon, 2 Mar 2026 11:50:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772448622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ11vK6VtIVd139Ojxs5lX7W/wK7C3IqSgUGtUMF/Tk=;
	b=luUvFsCRasCPcUrkKVKnAtbIOrxg4rL3l2Ho6jb0Sr9ebUjjDOodCMV6DEFK+OLsdjhnlx
	Vo53M6cpIua++yWOi99HU/jxlsdZBNrWFtIOO6eVjV0wpXCLjugSDIj7psDMZR13yfEwrY
	e1o4vl9BKxXA34alW176Fkx/47Hji9j6qe6bpA/xC68rT7Q8WQnW7pcX3rmBXX56DUiZqf
	3mQJqlHkeHCjPc5uffcQoh3DrFQoa2lMqSdSsCdTNSZm9qqBIX+PhL9veQuN72GRMObuvt
	DDmV/zme3z1uE7L9AZHycWpapiaUBW6t0JKY1MqMNMNyQgBWCIv/iDnlUUXBIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772448622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ11vK6VtIVd139Ojxs5lX7W/wK7C3IqSgUGtUMF/Tk=;
	b=Wecf0X0QCqKCWRC00mFP5q3KVKxeVz52yJ5P7FF+yXVbrqHG3w18h2LGlu6PSCc9uvnhp1
	AR7irSQo3cS+c+Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/6] ARM: use BIT() and GENMASK() for fault status
 register fields
Message-ID: <20260302105021.JEoFiIoj@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzch-0000000AwoC-3JkD@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vvzch-0000000AwoC-3JkD@rmk-PC.armlinux.org.uk>

On 2026-02-27 15:19:23 [+0000], Russell King (Oracle) wrote:
> Modernise the fault status field definitions by using BIT() and
> GENMASK().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
