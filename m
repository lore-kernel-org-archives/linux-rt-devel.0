Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0B4218AA
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600345; cv=pass; b=D+gTnM3tjOu4vPFkuTNbho064XkncPDRmLR6d2ccusa6lU79cev3V5CgVBjWqPEX35TVVtYD5BP7wZwz4yPZYUX2Y2lpYfxWohrMbfSbyFNCC2XJz9Z9nWyj5Y9D76H0vwGbtS+/v1mi6J6tWX0A6Sxkvx5k7J3UGcCsF9H9Lgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600345; c=relaxed/simple;
	bh=HpM5oyfiz/PBhye6COIAJQLw8QryulxM6H5RQMFWI74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mud286IJqqvjq2pmt4m3zYk9mcl/lreecGFN2FRorjyiV8D5Rz6euVDNrPQeL879rE5gP6GQef7YgELTnHVP8Rpftra3/myGAEKCpY/Bs6BCjJwb2fJIfLQtCkbhOTOw/8OB5iCBo91LS+AFqt6025h7gNRzv3dmD+CKxylCdT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=KsXlrmft; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="KsXlrmft"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a324d200c2so1182996eaf.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 05:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600342; cv=none;
        d=google.com; s=arc-20260327;
        b=Qsqwf7kBBrdzMaNdkia4c+oqLOJwraPluwPKo6eT7EUVFzV1mGZ83pKO7sE/Ck6dUw
         w+CIMMtrYbCejrc4sKCNf3gggTYLOYcUM33Huyo6gJ8hc3KoF4qZCE9XQeNlqEiKn/Wa
         haQZA8iUy++IOw/WAeXyDlKqjZfDJAxwtVOUi8ZkQ0uZ5rFH4cP3rdej19yL8ZP4anj9
         vJE6P7+yWJGBbAjdoMehgVGgPZKL8xcbIrBzFElyU9yPGxqqa4/BQuUy0ZA1BDSrFj2v
         zr8sbs/732JogVQY5PRzIw6yt4RhAdYAdzwi7kvU6X1xhhrg6ZP4H0K01C8h7i6DhugP
         +O/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q6uaaRn1apsA/2p+t1DBPwc+zrUv3t/8R7VmEga46LQ=;
        fh=nvjmXcCjvnYy9lTG//O6+nDXfQPpvboDnKanqscZzqA=;
        b=BEjoR6Zw+fRQoPQlQzC4WH5DRO2yxIzJVLsVE6YevhkmABh07e11VVPvfBCXPIqlR3
         3jSyZYooOhF0/6K6FTrAGIhBlq3vhge1x2aityuKsnv1+GWj4FZvI73LTePgupPiEFNg
         7+L5xTiI2UfrWEbFaMgGOUTvwS8FqOCuptFF/Gb7jsdeaXVmgGwDNOlFvqrwtlfqVyTc
         511Z/ex0kIYZJjf5ibJ35QXG17HkTdEmjZHHs1JbWuRlU+UAAF9KR9mZy0TutyFeleiX
         7AtXSjqHznrSQbq9w3uQ/LZtKBYSlgYrr6KHvkhW1kZn0QRy6rsgTDX9dSxlvNQEZ1lr
         Qlqg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783600342; x=1784205142; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6uaaRn1apsA/2p+t1DBPwc+zrUv3t/8R7VmEga46LQ=;
        b=KsXlrmftUxxdmYMGg2cHf2i1jWLW5jJWxgSkN0MwAMbjBKuHmthpBa0LEjeOuTJpyp
         9Qddltm8bWf0oNXMWB+5GUuE5sedb82dyiny/y8mLrFTaEfFA6Js+aNYeItaTROCQBBH
         9PUFUGPoa7QPerkJj4feV5JjIW06b6AZrQh56NksMrMbXZ3RrekSvu5xF7dX+756GECj
         W55nR6xipTJSYR3BxfLy7HRlKkpsMFteiBQYjd0gyOn7gnz2AQTKwvyaEuYWt6NE3iPw
         phfPDTRfQANEtK+kFKM5c18c80gzGJWBvlp/nfu4Qql3uaVAeggxtQbg2uFHRRl3YV/z
         ZyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600342; x=1784205142;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q6uaaRn1apsA/2p+t1DBPwc+zrUv3t/8R7VmEga46LQ=;
        b=f+W5LVvTxjCbFT7rB7EAZ/Cegpz7RrWPWVQ/RpOOEtp6Tzcz4/RrLOFHBe04XD5rOc
         6gnIlwPHgtTWSsGoJWGivEZQVCnUnkhyXkQm4lJo03bMZdSwSOnaNz7fDgtTcYwD4E9f
         Gl/KxUyjJAZgrGf7d13y9VJMy0P9zACZFFt/KIONDk0bj94JfyxkoDzXwDsic9oxFvAF
         bRaSgs3b/i6A16/OnrNb0z93M3YpxFX72/4xsVwH26b7Ly083FmdP+H5Cv5L9/a7rCAu
         /Mu0k+r3jF8PTiqwWHBzjDbR6m4NlUSYNFkaKdXwQTCfKhEjiD8lnRRm7hdSisItt8Vw
         Sy4g==
X-Forwarded-Encrypted: i=1; AFNElJ+T6dVrKm9XyAqJ62RyCXJ5pq1E1VNUK4ewLHG0B/oIbCIJud6z+jzOM8lkXfwFYBqE8ies8okfaLlXmskSQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyCzMoxV0Kkkj2IX1tGmp5cQJuiatsDNBKLUrkmBA+ghET+7HE
	q0BUHQan3+GnwMtlFI74rrqabJht6Zuf9FT8eSlWVXh0hT8JPDGwHRfajSgyZg8W0lUn8ezoB4k
	E4ELesoKmr6Bq2FYu2HWPNjsyxiBn7FDHXl7D+5LwWA==
X-Gm-Gg: AfdE7cnqEDhKmqz3UREuNOTd9RNyOMFXUIdSimeeLFqGp3fwgwSVIRAzGOlPJzQBrzE
	mwqkVVy1M5rVfDg0ac6y5TTnH31uqFu8Ihp6/4YloodZAG68jj7O6quGZmbZnjs6W2Zd6Fi5/kd
	cuNsZlkRo/Wx3xjzHIrMtSanoeKAGsSTAhwIAXQ/Hu3j8Ts6wFeBhC5SwZx65HDXZ27NHahL4Lc
	MIlCkTbwGfsNJnlCEP3maI5T/gLmQbu5mEjQehdsEhElLeeN0a6/BmFZq3Qz+vuQ81ZF+nmY85K
	9T+PGK45Q9IrH1kwKkd5CgYBBLQzZY8pMVCrx8juPbPqjSSYwGkj3hgD8B4bol5ftJjbTXtXt6s
	vyQK5XuljwaK8dW0UPnOKLeul1rfglB7Xbh4w3tA=
X-Received: by 2002:a05:6820:1628:b0:6a1:18fc:519f with SMTP id
 006d021491bc7-6a36d6d6ec2mr5214376eaf.0.1783600342380; Thu, 09 Jul 2026
 05:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-2-f9883d36aa4b@thegoodpenguin.co.uk> <ak5mPxUdp2pzCMt5@pathway.suse.cz>
In-Reply-To: <ak5mPxUdp2pzCMt5@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 9 Jul 2026 13:32:10 +0100
X-Gm-Features: AUfX_myRkAQr3RlL8KDtHhqAkW7mutgbWnQw5V1Od8NNNQcLPSvfj_bgH0j4NKw
Message-ID: <CALqELGxjTZAXEp1C1CNO2tLbUpUChZW3DHcNgyhEu4Ma-ct2ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] printk: deprecate boot_delay in favour of printk_delay
To: Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Wed, 8 Jul 2026 at 16:01, Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2026-06-30 17:35:58, Andrew Murray wrote:
> > The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
> > are two distinct mechanisms for providing similar functionality which add a
> > delay prior to each printed printk message.
> >
> > boot_delay provides a kernel parameter for delaying printk output from
> > kernel start through to boot (SYSTEM_RUNNING), whereas printk_delay is
> > configurable only via sysctl and thus is only used post boot.
> >
> > Let's deprecate the boot_delay feature in favour of printk_delay. In order
> > to preserve functionality, we'll also extend printk_delay such that it can
> > additionally configured via an early kernel parameter.
> >
> > Behavior change:
> >
> > The delay enabled by both "boot_delay" and "printk_delay" continues
> > working even in SYSTEM_RUNNING state. It must be explicitly stopped
> > by setting printk_delay=0 via sysctl.
> >
> > The delay is skipped when the message is suppressed in all system
> > states. It used to skipped only for the boot_delay.
> >
> > Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
>
> Looks good to me:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Note that Sashiko AI warns about possible problems with negative
> printk_delay values, see
> https://sashiko.dev/#/patchset/20260630-deprecate_boot_delay-v2-0-f9883d36aa4b%40thegoodpenguin.co.uk
>
> But they should be handled in both the early parameter
> and sysctl interface by the "10 * 1000" and "&ten_thousand"
> limits.

Yes, that was my also view.


>
> The only potential problem might be a warning about possible
> "sign" mismatch from the compiler. But I do not see any
> even with make W=2.

I suspect this will come up everytime a change is made in this area,
or perhaps some W=2 errors will pop up via kernelci or similar. I
propose updating the patch as follows:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5278d9cb19e4..fbb67f10c21e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1338,10 +1338,13 @@ static inline void early_boot_delay_msec(void)

 static int __init printk_delay_setup(char *str)
 {
-       get_option(&str, &printk_delay_msec);
-       if (printk_delay_msec > 10 * 1000)
-               printk_delay_msec = 0;
+       int printk_delay_val = 0;

+       get_option(&str, &printk_delay_val);
+       if (printk_delay_val < 0 || printk_delay_val > 10 * 1000)
+               return 0;
+
+       printk_delay_msec = (unsigned int)printk_delay_val;
        printk_delay_calculate();

        return 0;
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f15732e93c2e..f256fc05faaf 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -46,7 +46,7 @@ static const struct ctl_table printk_sysctls[] = {
                .data           = &printk_delay_msec,
                .maxlen         = sizeof(int),
                .mode           = 0644,
-               .proc_handler   = proc_dointvec_minmax,
+               .proc_handler   = proc_douintvec_minmax,
                .extra1         = SYSCTL_ZERO,
                .extra2         = (void *)&ten_thousand,
        },

This makes the cast explict, verifies the range before casting (I
guess a range of negative values could result in a postive value
within the 10,000 range) and also uses the correct proc_handler.

This has the side effect of not showing the following pr_debug for the
lpj calculation when a delay is not set. Though loops_per_msec is only
used during boot, so I don't think there is any loss here.

        pr_debug("printk_delay: %u, preset_lpj: %ld, lpj: %lu, "
                "HZ: %d, loops_per_msec: %llu\n",
                printk_delay_msec, preset_lpj, lpj, HZ, loops_per_msec);

Can I keep your Reviewed-By with these changes?

Thanks,

Andrew Murray

>
> Best Regards,
> Petr
