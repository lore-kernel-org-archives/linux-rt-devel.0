Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4E3FBEBC
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932318; cv=none; b=i+PM1IMy9U43Ys74E2Io8WfwZT7OdaTjTuKgol/a9q51fNt/aFc3qeM11yQgwm5xluFYfzflvr8LhWDFjAmYvyC/Rista+cfeOwSEUtc2kUxB94805Za1Jnu3KeKJoQNZxHPFa6MAHCLgeSXLG/hYpmS+OCaX11CN8RYViRPeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932318; c=relaxed/simple;
	bh=Jfb67EGEmTnY0y0CSlnJaQqcG/N3JhPxbkmiRukseSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOPX1mH62hdMjUiWeDtlg30BZ3i4UqhKIPY45Fq+Zc4CXTqFpXy7ikPf2mFmeDpSNEkMob+MH51B0HOJV3Kdau4I8g3rxLrCBXeVwpDGaLVuVqyyYde8D6FCCVWrZZKopj2G5C4/YZQc2mHWETOT6a738+wt5YVRLiGOrEBJX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NUx/xL5+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NUx/xL5+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b9318997so33096365e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 08 Jun 2026 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780932315; x=1781537115; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr7c+3FOU2JcV480M9kUOHZt6iGvTylWPKVomVAcFf4=;
        b=NUx/xL5+ZIfaqKbcPoOKpEt3MhjhMlIOQb2tuPlnFl1TpMLiqc6mrM3oD/jQ9m6Dup
         qXxlEefGHct7NNg4ryIyEdxipgFnC+WPSnLfp2iU1+XP6KTmwwsAB5icB8M5s+vqi3Cn
         9J5V9TWpieaOMcLb/+qDHQMA6N+SW/j6OBDiBhVHWUwD2CbsDnr+THTH+aKeSURUtNWV
         gVlLFiPvHkoiiTE48fNtNi9b1D1k+s9u0CdJnTEPD64OBfgrgA5mLMy1gujpySFhBpSx
         ZCrfYJbUktKoY58rfnFehArXeqjdrAa7otRQ+AHTVw+Y8QJNwUKe0lfICo84XmuYWB7H
         dWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932315; x=1781537115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr7c+3FOU2JcV480M9kUOHZt6iGvTylWPKVomVAcFf4=;
        b=OZX26i6J66865Wus44nj0YhDqb5+dTEFNohCeVMDLBndVfkl9HC28jSXubqWNseq/+
         hWsaZoihx3sNB751+VuLy+0PqCaYdN2TgvLItDaOzaIjPULaYYI/i7o41yTTTUtK7nGl
         tNVcnF0tGZo5eiJarazvFkiCr5fUkUlsco+Hj6Fn34+43n+eVLnMBmLLTJxhm2AcVnOK
         P6c1dEufIQPV7T6AkNe6dfEeZq1ejD+Zi1IQaJInL56NDGxS0FQQVo0rUnTD8+zUIoU5
         +T8jIXhorQt64643Cd4HOGqKKPq5LEPvn40KsmHoEJAAsfIRKUcT3acXi9O6hYpCuHRb
         KUXw==
X-Forwarded-Encrypted: i=1; AFNElJ+k9+7muD4CKYa5Cbhynv795tHPzXg9JMdvDEtzf6wWFVN7e+xwkklffKfU/fH21M5exlIAwqokkZPGq+tMrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCTo7QNIrzm++uYKnLaokcPZ35Zx3945y6DtyMtIT0MbYoSq+s
	zVDfot5oFsBXrFYmKHf/Z3yvG4OQBy49xqYtfu3jHtKeOZwm6yXEs/rCqrJJ1ftJMQg=
X-Gm-Gg: Acq92OEkIZDX1KamoHhYabGGDWVALx4t6Re33GfMOAjX5HALLuXXIQD4heGSwbJPlp0
	NKHYnC9Ez6nkKwZQbdLncN3+BNuPCT6Z0zvd2XWzcbmsnrJi+1CECd0CNl1pfJohsVUtszG6Ctd
	z2LFcifJeeQhnJP49gqoma5xJIm6SMSdkwquUxAMQzkxHt7MWjZQqDJ8QdaIsARMfGpyoDDlCqE
	8lXloJmeKAenZWKOb9+byNqD8z5wd3sZBL9hUJ/++X//xM/IASmXbUzRJKaS3iJLtMUtDnrOo+O
	RzQBwUrFIovZi2IgDdgtUbiJrggbBizjD3UB97x7sI/so3TjGDrlkA+GlhtI5PjzFR9saB+zm+p
	Bf022RrviYqnfFsk+BhddE9GB3uiMBrM8BWH8xlassE6ebzo19Q5VN7k6Uxqi0yPNRe4V2Zg9j+
	YLv7iAd1KK2u0t417WVUmfJXZlpaQpE1Nyes72
X-Received: by 2002:a05:600c:34c3:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490c2599e11mr294852765e9.7.1780932314828;
        Mon, 08 Jun 2026 08:25:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm369305055e9.3.2026.06.08.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:25:14 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:25:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 3/4] printk: nbcon: move printk_delay to console
 emiting code
Message-ID: <aibe12WcrLxVWTez@pathway.suse.cz>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-3-c34c187142a6@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-deprecate_boot_delay-v1-3-c34c187142a6@thegoodpenguin.co.uk>

On Mon 2026-06-01 00:17:39, Andrew Murray wrote:
> The printk_delay and boot_delay features are helpful for debugging
> as kernel output can be slowed down during boot allowing messages to
> be seen before scrolling off the screen, or to correlate timing between
> some physical event and console output.
> 
> However, since the introduction of nbcon and the legacy printer thread
> for PREEMPT_RT kernels, printk records are now emited to the console
> asynchronously to the caller of printk. Thus, any printk delay added by
> boot_delay/printk_delay continues to slow down the calling process but
> may not have any impact to the rate in which records are emited to the
> console.
> 
> Let's address this by moving the printk delay from the calling code
> to the console emiting code instead. Whilst this ensures that delays
> are still observed (especially for slower consoles), it doesn't improve
> the use-case of using boot_delay/printk_delay to correlate timings
> between physical events and console output.
> 
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h

The declaration is needed just inside kernel/printk/ directory.
It should better be done via kernel/printk/internal.h

> @@ -209,6 +209,7 @@ extern bool nbcon_device_try_acquire(struct console *con);
>  extern void nbcon_device_release(struct console *con);
>  void nbcon_atomic_flush_unsafe(void);
>  bool pr_flush(int timeout_ms, bool reset_on_progress);
> +void printk_delay(bool use_atomic);
>  #else
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)
> @@ -326,6 +327,9 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
>  {
>  	return true;
>  }
> +static inline void printk_delay(bool use_atomic)
> +{
> +}
>  
>  #endif
>  
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d7044a7a214bdd4537a5e20d876d99bc3ffe8b3a..a507a2fed5bf4366e24330f763b842a698ecf6f7 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1267,11 +1267,16 @@ static int nbcon_kthread_func(void *__console)
>  
>  		con_flags = console_srcu_read_flags(con);
>  
> +		wctxt.len = 0;
> +
>  		if (console_is_usable(con, con_flags, false))
>  			backlog = nbcon_emit_one(&wctxt, false);
>  
>  		console_srcu_read_unlock(cookie);
>  
> +		if (backlog && wctxt.len > 0)

Heh, this is tricky. It might probably work but it is not guarantted
by design.

The "backlog" name is a bit misleading. The value is basically
wctxt.ctxt.backlog. The real meaning is that printk_get_next_message()
was able to read a message. It means that there _was_ a backlog.
But it is not clear whether there are still pending messages or not.

Also it is not clear that whether the message was pushed to the
console or not. It might have been supressed in which case
(wctxt.len == 0). But it might also be emitted only partially
when a higher priority context took over the console context
ownership.

I would prefer to explicitely set some flag when
nbcon_emit_next_record() really called con->write*().
See below.

> +			printk_delay(false);
> +
>  		cond_resched();
>  
>  	} while (backlog);
> @@ -1525,6 +1530,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
>  	}
>  
>  	progress = nbcon_emit_one(&wctxt, use_atomic);
> +	if (progress && wctxt.len > 0)

Same here.

> +		printk_delay(use_atomic);
>  
>  	if (use_atomic) {
>  		start_critical_timings();
> @@ -1584,6 +1591,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
>  			if (!nbcon_context_try_acquire(ctxt, false))
>  				return -EPERM;
>  
> +			wctxt.len = 0;
> +
>  			/*
>  			 * nbcon_emit_next_record() returns false when
>  			 * the console was handed over or taken over.
> @@ -1595,7 +1604,9 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
>  			nbcon_context_release(ctxt);
>  		}
>  
> -		if (!ctxt->backlog) {
> +		if (ctxt->backlog && wctxt.len > 0) {
> +			printk_delay(true);
> +		} else {

This changes the semantic. The original code call this when
no message was read. The new code would call this path also
when the output was suppressed. It would probably work.
But still.

>  			/* Are there reserved but not yet finalized records? */
>  			if (nbcon_seq_read(con) < stop_seq)
>  				err = -ENOENT;


As mentioned above, I would add a flag which would be set when
con->write*() was called.

It modifies the type of unsafe_takeover in struct nbcon_write_context.
But it actually makes it more compatible with struct nbcon_state.

My proposal (on top of this patch):

diff --git a/include/linux/console.h b/include/linux/console.h
index 5520e4477ad7..5a86942e55ef 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -290,6 +290,7 @@ struct nbcon_context {
  * @outbuf:		Pointer to the text buffer for output
  * @len:		Length to write
  * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ * @emitted:		The write context tried to emit the message. Might be incomplete.
  * @cpu:		CPU on which the message was generated
  * @pid:		PID of the task that generated the message
  * @comm:		Name of the task that generated the message
@@ -298,7 +299,8 @@ struct nbcon_write_context {
 	struct nbcon_context	__private ctxt;
 	char			*outbuf;
 	unsigned int		len;
-	bool			unsafe_takeover;
+	unsigned char		unsafe_takeover	:  1;
+	unsigned char		emitted : 1
 #ifdef CONFIG_PRINTK_EXECUTION_CTX
 	int			cpu;
 	pid_t			pid;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index a507a2fed5bf..060534becefc 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1069,6 +1069,9 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	else
 		con->write_thread(con, wctxt);
 
+	/* Tried to emit something. Might be incomplete. */
+	wctxt.emitted = 1;
+
 	if (!wctxt->outbuf) {
 		/*
 		 * Ownership was lost and reacquired by the driver. Handle it
@@ -1267,14 +1270,14 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
-		wctxt.len = 0;
+		wctxt.emitted = 0;
 
 		if (console_is_usable(con, con_flags, false))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
 
-		if (backlog && wctxt.len > 0)
+		if (wctxt.emitted)
 			printk_delay(false);
 
 		cond_resched();
@@ -1530,7 +1533,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 	}
 
 	progress = nbcon_emit_one(&wctxt, use_atomic);
-	if (progress && wctxt.len > 0)
+	if (wctxt.emitted)
 		printk_delay(use_atomic);
 
 	if (use_atomic) {
@@ -1591,7 +1594,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 			if (!nbcon_context_try_acquire(ctxt, false))
 				return -EPERM;
 
-			wctxt.len = 0;
+			wctxt.emitted = 0;
 
 			/*
 			 * nbcon_emit_next_record() returns false when
@@ -1604,9 +1607,10 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 			nbcon_context_release(ctxt);
 		}
 
-		if (ctxt->backlog && wctxt.len > 0) {
+		if (wctxt.emitted)
 			printk_delay(true);
-		} else {
+
+		if (!ctxt->backlog) {
 			/* Are there reserved but not yet finalized records? */
 			if (nbcon_seq_read(con) < stop_seq)
 				err = -ENOENT;
