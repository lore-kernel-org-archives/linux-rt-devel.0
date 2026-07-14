Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D5377A97
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065896; cv=none; b=pJ00ciVcQ7/gheGrQ1rFdAaBtRY14hDKMR1vxztcdLFZBywHuGzZv7MSmdeDsZ2dYcwCNHKVnTZKyvn6QKTO7cob0h/npthPpPJsqwBHJhAmfa5MUZVFb7ThAsmaSOcMzMO2HIVMKeaR8hpFzgCFt0NqpzqXtuqKcWePdlls9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065896; c=relaxed/simple;
	bh=bXaz2qZoLuJcWKSqSMD6L56EptgMfeC1fMDylZ7aMcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4gcTSQdlYLTGV7Y8X9yKGKDXTb4hQjxBOF/BKX+PbfdUs3i5fauYkPyaUvkxRCNP+3hDhvKmNzjL3fzbWp/NEL1NZHy+Hs5S9/QHFebE8rmrU5OB5EdCQvPBfoJPKWk1bcgcWuLTg+KeyCljuVl1nolGXqvONesh57UhM7JOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 892F3804B0;
	Tue, 14 Jul 2026 21:51:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id A1A506000C;
	Tue, 14 Jul 2026 21:51:27 +0000 (UTC)
Date: Tue, 14 Jul 2026 17:51:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/6] Documentation/kernel-parameters: add/update
 printk_delay/boot_delay
Message-ID: <20260714175131.1edfc880@gandalf.local.home>
In-Reply-To: <20260712-printkcleanup-v3-6-574547b8f71b@thegoodpenguin.co.uk>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
	<20260712-printkcleanup-v3-6-574547b8f71b@thegoodpenguin.co.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7zy31kt8rbwtcxpe5riua91mpmyq316o
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A1A506000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CNmWd2YhLXQvEn1XaHEtwP0wzcKYWfXE=
X-HE-Tag: 1784065887-653010
X-HE-Meta: U2FsdGVkX18t0ruRrD4DDDo0OZ1UA5N76Mf6Lk9oRwOylkSPIbsZWq73qoTz/bkApRB0oxXicLVMDXuK/ZC8dSH77knGTVCpJAZxUxtyvEH/UImu4r3aD8mxRcA5JsRDxTK2N0nO/Q3xgVVpTuV+t1StncIDm3pwv3kYfoeMs8Jg0EJem2UEWPdzi9oJndMRunIH/kS0lPHLDnjK39PoWXSlEiQYG7RJMAz69lnU0kl6Sb7Keuvboe2QUYC4iTAc0pSUneUfPyg9zXOkZ7TN5xPibPrdNOnPExVT/RiRYqicpYieJo2Af3W1FtfKy6YFNnYkT1kxOd8XliV8F5iK8P87+FxnmpA29LqdXki/3Q9gI9m/b6mxPiufh8MKnRsU

On Sun, 12 Jul 2026 11:20:37 +0100
Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2884103b93bca7b76cd3a93946276074cf62d0a1..1118feda87b1b04543b1da0bd52c090b1fddaeac 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -650,11 +650,19 @@ Kernel parameters
>  			See Documentation/block/cmdline-partition.rst
>  
>  	boot_delay=	[KNL,EARLY]
> -			Milliseconds to delay each printk during boot.
> -			Only works if GENERIC_CALIBRATE_DELAY is enabled,
> -			and you may also have to specify "lpj=".  Boot_delay
> -			values larger than 10 seconds (10000) are assumed
> -			erroneous and ignored.
> +			Milliseconds to delay each printk during and post boot.
> +			Boot time delays only work if GENERIC_CALIBRATE_DELAY
> +			is enabled.
> +
> +			Once booted the delay can be removed or adjusted via
> +			the printk_delay sysctl.
> +
> +			Please note that you may also have to specify "lpj=".
> +			Boot_delay values larger than 10 seconds (10000) are
> +			assumed erroneous and ignored.
> +
> +			This will soon be deprecated, please use printk_delay
> +			instead.
>  			Format: integer
>  
>  	bootconfig	[KNL,EARLY]
> @@ -5468,6 +5476,19 @@ Kernel parameters
>  	printk.time=	Show timing data prefixed to each printk message line
>  			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
>  
> +	printk_delay=	[KNL,EARLY]
> +			Milliseconds to delay each printk during and post boot.
> +			Boot time delays only work if GENERIC_CALIBRATE_DELAY
> +			is enabled.
> +
> +			Once booted the delay can be removed or adjusted via
> +			the printk_delay sysctl.
> +
> +			Please note that you may also have to specify "lpj=".
> +			printk_delay values larger than 10 seconds (10000) are
> +			assumed erroneous and ignored.
> +			Format: integer
> +

The two parameters descriptions are identical. They should show something
different. Is it just that the "boot_delay" name is getting deprecated?

-- Steve
