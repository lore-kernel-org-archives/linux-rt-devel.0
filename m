Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD398355053
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720350; cv=none; b=rxGXTJ+wJIejLm3Gwo1IdI5CKTIFJu0/0CFHVHp2c1fzlGPcGggiyujObNLmyEfbTt5oOrhAv3kW30n93m5BbY3nPmA1sGMLeLdAEiyExO9Fxb700wZeg66Z/6xpgyW3xzLwSWTS2qE4SudDuUD4pGkLDY/RSDIvrPdYfvvd/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720350; c=relaxed/simple;
	bh=3uJqwJM0bl9ZiVV2Hxw6d3D+o5ZQXALozH26J9EHvEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJbDUAS3oC48u3TK9zTB2elBKUzunt8S+pYQRA0hfxG2veZqqdXkw3DyyWDPQBJAnSxfswn3ZlSOheSJb8LhWWyNS3TuHZBMBkZymTQ+NltTUXnlB8t3b2f3gF/OusdHxlGmaU49ASuJk8Cyo34PkpJCDpV76Zwr3AQDsfCse8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Cd1dby0N; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cd1dby0N"
Received: from pendragon.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id EB1EE78E;
	Tue,  6 Jan 2026 18:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1767720326;
	bh=3uJqwJM0bl9ZiVV2Hxw6d3D+o5ZQXALozH26J9EHvEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cd1dby0N1n5olIOLPHG6z16ntzOmrBtUru8/UFBkPlkbclxsdvR+37/QtD595SHsc
	 glGJ3LTNOZ9TGrRBneI2+NLOqkfQzs2lPbot2fQ7agIWEdMLrT6Al1KymYEaEu5K39
	 jzqrRoR4l6KOojzu8MiW7OcclOgs4PJe1107yijQ=
Date: Tue, 6 Jan 2026 19:25:28 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Stefan Klug <stefan.klug@ideasonboard.com>,
	Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Hans Verkuil <hans@jjverkuil.nl>
Subject: Re: [PATCH 1/4] media: dw100: Implement V4L2 requests support
Message-ID: <20260106172528.GF26157@pendragon.ideasonboard.com>
References: <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-1-65af34d04fd8@ideasonboard.com>
 <40dfd12b585681d8edf9641967160c086cc120c3.camel@ndufresne.ca>
 <20260106003302.GJ10026@pendragon.ideasonboard.com>
 <176770897731.12184.12302111059048415045@localhost>
 <20260106145354.GB26157@pendragon.ideasonboard.com>
 <f4eef909a0f9b787dd4720fe005de0c4e41f5c5a.camel@ndufresne.ca>
 <20260106154517.GD26157@pendragon.ideasonboard.com>
 <c4f20e7f67f40b13469ea2504f0990ddbce59708.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4f20e7f67f40b13469ea2504f0990ddbce59708.camel@ndufresne.ca>

On Tue, Jan 06, 2026 at 10:56:09AM -0500, Nicolas Dufresne wrote:
> Le mardi 06 janvier 2026 à 17:45 +0200, Laurent Pinchart a écrit :
> > > I explained it in another thread, it is only called if device_run() is not going
> > > to be called, so only once. vb2 does not have access to the the control handler,
> > > so it can't call the v4l2_ctrl_request_complete() fonction directly.
> > 
> > But the function is called per queue. If a buffer has been queued on
> > both the capture and the output queue for a request, won't the operation
> > be called twice with the same request ?
> 
> Only the OUTPUT queues allow for requests at the moment.

Aahhh that's what I was missing. I thought the request would contain
buffers for both the output and capture queues.

-- 
Regards,

Laurent Pinchart
