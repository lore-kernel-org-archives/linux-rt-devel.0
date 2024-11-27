Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02881F8F1A;
	Wed, 27 Nov 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727344; cv=none; b=aoUjhoTZputcts8XL3w+UW9n+WMGX5PleLZSay/ff/XuoNF3g9izj9VaFN/iH0BY2f9ZvOshkfJ2U801HwN2k8BlE4kPiwlj8if8jVKMXxFJGaXonZsVbT5UQKERnHxBXccP23XmXNwFfD0Luf+vj4h3v/gNv9kNy4rZgIYn5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727344; c=relaxed/simple;
	bh=8VEm8aUEJUZUBfqieyeV6sPe94ptDwIYS4xqe8ZQD00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9aEiK9uODuil6BlRc9NsYat/pZjs1u7pxX7YqFdPqIRcoPpiZHrIfKA0srUs1iwzH8F+v6B/oXeTmMJdy8v/gMXh1tWc9CickiBoefC9XOsyr11gTp9yEprYLNCAIzx4t2jOic3gUiKWDavpeX2J+nlSsP2QA4L/OTBRsyfOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D015C4CECC;
	Wed, 27 Nov 2024 17:09:02 +0000 (UTC)
Date: Wed, 27 Nov 2024 12:09:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, mike.leach@linaro.org, james.clark@linaro.org,
 alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, nd@arm.com
Subject: Re: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Message-ID: <20241127120954.0facd34f@gandalf.local.home>
In-Reply-To: <20241125094816.365472-2-yeoreum.yun@arm.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 09:48:08 +0000
Yeoreum Yun <yeoreum.yun@arm.com> wrote:

> @@ -853,17 +851,14 @@ EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
>  void cscfg_csdev_reset_feats(struct coresight_device *csdev)
>  {
>  	struct cscfg_feature_csdev *feat_csdev;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +	guard(raw_spinlock_irqsave)(&csdev->cscfg_csdev_lock);
> +
>  	if (list_empty(&csdev->feature_csdev_list))
> -		goto unlock_exit;
> +		return;
>  
>  	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node)
>  		cscfg_reset_feat(feat_csdev);

We should start documenting what is not real-time "safe". That is, if this
code is executed, we have a loop here that holds a raw spin lock. This
appears to make the time the raw spin lock held to be non deterministic.

If someone is running PREEMPT_RT and expects deterministic behavior, they
cannot be using this code. That is fine, but we should probably create a
document somewhere that notes this.

-- Steve


> -
> -unlock_exit:
> -	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
>  
