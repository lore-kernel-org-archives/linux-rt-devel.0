Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293172ECEA3
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Nov 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658085; cv=none; b=iMcX3emejdQzarP0zhz6bic3/b/+7PPVYXgAtJK3YyJTVo58D/YUWyrcViqLtO0qJvsoS0mGywHMrwluybvPwoAcxFzXXoCXimpwRHT4LDVOH9lJhGVDYg+nbSoLajLu+1IVpzTFzYyY7Z0/oLQ57Ysc4d9L9XPxYo2zDa7lvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658085; c=relaxed/simple;
	bh=TkpOwHtF5LJnOc2a1tGVUuodYnNcHIwiksPn1c7zfso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StPO28DS47qOlBvW97mH/H6ZSy9kwDhz9N7ZeZPAgdufedotnzTeX3XnGxQFpp9OXnDEriOhPGoGtb+G2BhssASUiECEakq3y4HOMdSyl0A7jb50ZpCQ6+Ea3MLsC+l/fz4JJhiEyD0NPWHslcpzPXMIs+KrHEoetpuKEwHxMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B608D86BDA;
	Thu, 20 Nov 2025 17:01:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 9404530;
	Thu, 20 Nov 2025 17:01:12 +0000 (UTC)
Date: Thu, 20 Nov 2025 12:01:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>, John
 Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] Documentation: Add some hardware hints for
 real-time
Message-ID: <20251120120144.1725ef3e@gandalf.local.home>
In-Reply-To: <20251120113708.83671-2-bigeasy@linutronix.de>
References: <20251120113708.83671-1-bigeasy@linutronix.de>
	<20251120113708.83671-2-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9404530
X-Stat-Signature: pu1kwd3i74ibddc4rwfmktbe5wzuerdm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/u6RIpLEd/pPmmxmxTxhkLQuIJG+7Fu+I=
X-HE-Tag: 1763658072-575639
X-HE-Meta: U2FsdGVkX1/g7eESry6NRcMJWnrdDL83qWPFwvQegMZ3rKRkisggegbfCVOs/malU9hYF1krkmKR9i9zPxRXWf2WxoGgHe9lwkihyDk3IQDRfwuI6oVwqHioxlfw0O963spmI6ICVfD/A6GprLXL7BFcBtPFljifAIEFUBAQqpSt1aGv9eveCwAPwQn4lR1KqC1yJYf7ZYg6Y6DIliqDgia3lEBsDQiHMsPx3luaL9cQVqxaabx8g4ESZ6L2Qt1oX/gFIGLsyQWmXUaAh3lfbBU9owVROXK9hunBcG177Gn64M5LZamT61GVmkjuY+6SpDpIxqppB/PBgJTS0d5n3kJImcJzyOX4R16fGBY9x1w2wbYdx6QqpwWi3+XQRGAO

On Thu, 20 Nov 2025 12:37:06 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Some thoughts on hardware that is used for real-time workload. Certainly
> not complete but should cover some of the import topics such as:
> 
> - Main memory, caches and the possiblie control given by the hardware.
> - What could happen by putting critical hardware behind USB or VirtIO.
> - Allowing real-time tasks to consume the CPU entirely without giving
>   the system some time to breath.
> - Networking with what the kernel provides.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  Documentation/core-api/real-time/hardware.rst | 132 ++++++++++++++++++
>  Documentation/core-api/real-time/index.rst    |   1 +
>  2 files changed, 133 insertions(+)
>  create mode 100644 Documentation/core-api/real-time/hardware.rst

Very nice write up!

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
