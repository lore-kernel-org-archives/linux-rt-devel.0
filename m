Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F632B9A8
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Jan 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612988; cv=none; b=GZJ4/ZlNmRg4tpDvY+w6PDXKLFJ2UipgI4gUey89mhFhn4Yd+NH3jU3DosBfe6Y6GVHsgVEDJvGkvAJks69mNTYMT4EaepaAzmYeyiCreOxuMO5f5RKnPXjw61xHz+yZsc4l9fk0INKK/DMECtnKetyVaIGxasRuRALa0pN46kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612988; c=relaxed/simple;
	bh=XR44IfZoG7E2F15OfJorFS0OEFQAHjTSH3tln9pFcJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FdfoB+0N0ibUfFxIBeIlQ2zAc3q/dz1X4bKRra/0cfVn+zDwNyLmrfm+1+GsZQecYtxuz0uoQ+W0jmjZ6BN0kZ7CNso7Jth2CBAnGqtf6FpYH2/PI7NA8C7gAjkRGbMSz1x1B65td178M+UVkgwQKI8hb8tzGYA5IGdyVehd0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QyrRu6PV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QyrRu6PV"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:c12b:c5c7:ad08:9cf2])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 0F8FB8CB;
	Mon,  5 Jan 2026 12:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1767612965;
	bh=XR44IfZoG7E2F15OfJorFS0OEFQAHjTSH3tln9pFcJ4=;
	h=From:Subject:Date:To:Cc:From;
	b=QyrRu6PVYoQvJGDg/qYpx2qY+lBIEow7F6sLdwv02A7JVnhbKx3nOjRHHh27zwyCH
	 N7UOEAxo5dN2u/Rnj++YN3y5/MATT1L04XEDnrubGB71AGiho83GDgJwOosyEca9d/
	 sDLP9SfGPkvz49dxTojYODcGK3XBpSBf8TQgbkVM=
From: Stefan Klug <stefan.klug@ideasonboard.com>
Subject: [PATCH 0/4] media: dw100: Dynamic vertex map updates and fixes for
 PREEMPT_RT
Date: Mon, 05 Jan 2026 12:35:52 +0100
Message-Id: <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiiW2kC/x3NywrCQAxG4VcpWftDUpl4eRVxYTuxBqUtM3UUS
 t/dweW3OWelbMkt07lZKVnx7NNYIbuG+sdtHAweq6nlVlk4ID9f7wFFIYplmr1H/Agzyh6CaAX
 dMaiGQ+z0FKhm5mR3//4Xl+u2/QCTXktUcgAAAA==
X-Change-ID: 20260105-sklug-v6-16-topic-dw100-v3-1-dev-b856657db695
To: Xavier Roumegue <xavier.roumegue@oss.nxp.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>
X-Mailer: b4 0.14.2

Hi all,

This series contains a few updates to the dw100 dewarper. Patches 1-2
implement V4L2 requests support and dynamic updates of the vertex map.
This enables advanced use cases like interactive pan, zoom and rotate. A
first attempt to implement the dynamic update was posted a while back in
[1] but wasn't merged due to races in the implementation. By switching
to V4L2 requests the implementation is a lot simpler now.

Patches 3-4 fix an issue on PREEMPT_RT enabled kernels. These patches
should possibly be squashed into one. I expected patch 3 to be
sufficient but during testing I hit an error condition that is worked
around in patch 4. As I don't have documentation for the hardware it is
difficult to decide on the proper fix. So feedback on that is greatly
appreciated.

Best regards,
Stefan

[1] https://lore.kernel.org/linux-media/20241022063155.506191-1-umang.jain@ideasonboard.com/

Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
---
Stefan Klug (4):
      media: dw100: Implement V4L2 requests support
      media: dw100: Implement dynamic vertex map update
      media: dw100: Fix kernel oops with PREEMPT_RT enabled
      media: dw100: Split interrupt handler to fix timeout error

 drivers/media/platform/nxp/dw100/dw100.c | 89 ++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 16 deletions(-)
---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20260105-sklug-v6-16-topic-dw100-v3-1-dev-b856657db695

Best regards,
-- 
Stefan Klug <stefan.klug@ideasonboard.com>

