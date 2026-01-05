Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736293A1E74
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Jan 2026 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767656722; cv=none; b=IhMZnKrQf5hixTptQ1act1rTqR+ygN7vm+GuGKrvL1MW5U7SHKb+DmIfOhKlPJi1L4sAFc4ORS+QSAgbgXUe72sVn9tPSf/ndL0pUAZjD7a926pDWG4tLNQslWNzS9bBIMXB3eJXycF76pQfdQOoAKabRUgcSFpFMmQwjlqTaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767656722; c=relaxed/simple;
	bh=1udTEG1rrOGddP0tf1nuF4S9QpeftqT/36M8cqJBoAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciAOcRjU+TwAcZjipW5eixOyiUB7vDL+apwSFpHqJ+XcwWbBcmnwwyxVbo74YzTpF1LG92Bn0Bk4mTs5zl5NQbh4b3cfr6aM12Tik2GaC/CR5mMVqJSfcPQgZcVP9itdWKcnzExbP0+ToLZAWofkXLdyQtbrDCovqZKJVpsxc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HCApnSpg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HCApnSpg"
Received: from pendragon.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 67EA355A;
	Tue,  6 Jan 2026 00:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1767656690;
	bh=1udTEG1rrOGddP0tf1nuF4S9QpeftqT/36M8cqJBoAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCApnSpgg2YPavVNsNtNunjsth5gStYETUKtlZ7Mi+upr9BV589a88Kxqu5M2Z1UH
	 ZBdGM2CopVuxS49PnMbN6/5uk//XQmbPARnFYN6mTSJCFWB75FL8tL861yXRpVRAvO
	 OhBZbXZwH1IPUvhTNU0MusfV9CWQDu1nkbhE9R7s=
Date: Tue, 6 Jan 2026 01:44:52 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 4/4] media: dw100: Split interrupt handler to fix timeout
 error
Message-ID: <20260105234452.GH10026@pendragon.ideasonboard.com>
References: <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-4-65af34d04fd8@ideasonboard.com>
 <1c04d8cd1a6cf29f45d7ea9422dd3fe0a633a957.camel@ndufresne.ca>
 <20260105163748.2488d506@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105163748.2488d506@gandalf.local.home>

On Mon, Jan 05, 2026 at 04:37:48PM -0500, Steven Rostedt wrote:
> On Mon, 05 Jan 2026 14:03:58 -0500 Nicolas Dufresne wrote:
> > Le lundi 05 janvier 2026 à 12:35 +0100, Stefan Klug a écrit :
> > > In the previous commit, the interrupt handler was changed to threaded.
> > > This sometimes leads to DW100_INTERRUPT_STATUS_INT_ERR_TIME_OUT being
> > > set after changing the vertex map. This can be seen by repeated error
> > > outputs in dmesg:
> > > 
> > > dw100 32e30000.dwe: Interrupt error: 0x1
> > > 
> > > As there is no documentation available, it is unclear why that happens
> > > and if this condition can simply be ignored. By splitting the interrupt
> > > handling into two parts and only handling the dw100_job_finish() within
> > > the threaded part, the error does not occur anymore.
> > > 
> > > Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>  
> > 
> > Ok, but arguably, this could be squashed.

Stefan mentioned that in the cover letter, yes. The patches are
currently split because 4/4 shouldn't be needed based on our
understanding of the hardware. We're hoping for feedback on the issue
from someone with knowledge of the DW100 and access to its
documentation.

> Agreed. Because it doesn't seem to make sense to have a oneshot threaded
> irq handler that doesn't have the two parts (non-threaded to acknowledge the
> irq, and the threaded to handle it and re-enable it).

Why is so ? Isn't oneshot meant exactly for this purpose ? It's
documented as not reenabling the interrupt after the hardirq handler
(which is absent after 3/4) returns, why would a hardirq handler be
mandatory then ?

-- 
Regards,

Laurent Pinchart
